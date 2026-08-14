//
//  HistoryViewModel.swift
//  MacroBook
//
//  Created by Hany Wijaya on 01/07/26.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
final class HistoryViewModel: ObservableObject {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    @Published var currentMonth = Date()
    @Published var selectedDate = Date()
    @Published var weeklyBalance: Double = 0
    @Published var monthlyBalance: Double = 0
    
    var calendarDays: [DailySummary] {
        generateCalendarDays()
    }
    
    func computeWeeklyBalance(for date: Date) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let weekday = calendar.component(.weekday, from: startOfDay)

        // Sunday = 1
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: startOfDay)!
        let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!

        let week = DateInterval(start: startOfWeek, end: endOfWeek)
        let weekLogs = getAllLogs(in: week)
        
        let daysElapsed = weekday
        let calorieTarget = getCalorieTarget()
        
        let logCalories = weekLogs
            .reduce(0.0) { result, log in
                switch log.type {
                case .intake:
                    return result + log.calories
                case .activityBurn:
                    return result - log.calories
                }
            }
        
        weeklyBalance = logCalories - (calorieTarget * Double(daysElapsed))
    }
    
    func computeMonthlyBalance(for date: Date) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)

        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: startOfDay))!
        let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!

        let month = DateInterval(start: startOfMonth, end: endOfMonth)
        let monthLogs = getAllLogs(in: month)

        // Days elapsed in the month (including today)
        let daysElapsed = calendar.dateComponents([.day], from: startOfMonth, to: startOfDay).day! + 1

        let calorieTarget = getCalorieTarget()

        let logCalories = monthLogs.reduce(0.0) { result, log in
            switch log.type {
            case .intake:
                return result + log.calories
            case .activityBurn:
                return result - log.calories
            }
        }

        monthlyBalance = logCalories - (calorieTarget * Double(daysElapsed))
    }
    
    func getCalorieTarget() -> Double {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1

        let user =  try? context.fetch(request).first
        return user?.maintenance ?? 0
        
    }
    
    func getIntakeSum(for date: Date) -> Double {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: date))!
        let request = NSFetchRequest<NSDictionary>(entityName: "Intake")

        request.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@",
            startOfDay as NSDate,
            startOfTomorrow as NSDate
        )

        let expression = NSExpressionDescription()
        expression.name = "total"
        expression.expression = NSExpression(
            forFunction: "sum:",
            arguments: [NSExpression(forKeyPath: "calories")]
        )
        expression.expressionResultType = .doubleAttributeType

        request.resultType = .dictionaryResultType
        request.propertiesToFetch = [expression]

        do {
            let result = try context.fetch(request)
            return result.first?["total"] as? Double ?? 0
        } catch {
            return 0
        }
    }
    
    func getActivityBurnSum(for date: Date) -> Double {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: date))!
        let request = NSFetchRequest<NSDictionary>(entityName: "ActivityBurn")

        request.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@",
            startOfDay as NSDate,
            startOfTomorrow as NSDate
        )

        let expression = NSExpressionDescription()
        expression.name = "total"
        expression.expression = NSExpression(
            forFunction: "sum:",
            arguments: [NSExpression(forKeyPath: "calories")]
        )
        expression.expressionResultType = .doubleAttributeType

        request.resultType = .dictionaryResultType
        request.propertiesToFetch = [expression]

        do {
            let result = try context.fetch(request)
            return result.first?["total"] as? Double ?? 0
        } catch {
            return 0
        }
    }
    
    func generateCalendarDays() -> [DailySummary] {
        let calendar = Calendar.current
        
        guard let firstDay = calendar.date(from: calendar.dateComponents([.year,.month], from: currentMonth)),
                let range = calendar.range(of: .day, in: .month, for: currentMonth)
            else {
                return []
            }
        
        var days: [DailySummary] = []
        let weekday = calendar.component(.weekday, from: firstDay)
        
        for _ in 1..<weekday {
            days.append(DailySummary(date: nil, balance: nil))
        }
        
        for day in range {
            let date = calendar.date(byAdding: .day, value: day-1, to: firstDay)!
            days.append(DailySummary(date: date, balance: (getIntakeSum(for: date) > 0 ? (getIntakeSum(for: date) - getActivityBurnSum(for: date) - getCalorieTarget()) : 0)))
        }

        return days
    }
    
    private func getIntakes(in interval: DateInterval) -> [Intake] {
        let request: NSFetchRequest<Intake> = Intake.fetchRequest()

        request.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@",
            interval.start as NSDate,
            interval.end as NSDate
        )
        
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch today's intakes:", error)
            return []
        }
    }
    
    private func getActivityBurns(in interval: DateInterval) -> [ActivityBurn] {
        let request: NSFetchRequest<ActivityBurn> = ActivityBurn.fetchRequest()

        request.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@",
            interval.start as NSDate,
            interval.end as NSDate
        )
        
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch today's activity burns:", error)
            return []
        }
    }
    
    private func makeIntakeLogs(from intakes: [Intake]) -> [Log] {
        intakes.compactMap { intake -> Log? in
            guard let timestamp = intake.timestamp else {
                return nil
            }

            return Log(
                id: intake.objectID,
                type: .intake,
                timestamp: timestamp,
                title: intake.title ?? "",
                note: intake.note ?? "",
                calories: intake.calories,
                protein: intake.protein,
                carbs: intake.carbs,
                fat: intake.fat,
                serving: intake.serving
            )
        }
    }
    
    private func makeActivityBurnLogs(from activityBurns: [ActivityBurn]) -> [Log] {
        activityBurns.compactMap { activityBurn -> Log? in
            guard let timestamp = activityBurn.timestamp else {
                return nil
            }

            return Log(
                id: activityBurn.objectID,
                type: .activityBurn,
                timestamp: timestamp,
                title: activityBurn.title ?? "",
                note: activityBurn.note ?? "",
                calories: activityBurn.calories,
                protein: 0,
                carbs: 0,
                fat: 0,
                serving: 0
            )
        }
    }
    
    func getAllLogs(in interval: DateInterval) -> [Log] {
        let intakes = getIntakes(in: interval)
        let activities = getActivityBurns(in: interval)

        let intakeLogs = makeIntakeLogs(from: intakes)
        let activityLogs = makeActivityBurnLogs(from: activities)

        return (intakeLogs + activityLogs).sorted { $0.timestamp > $1.timestamp }
    }
    
//    func getDailySummary(for date: Date) -> DailySummary {
//        let intake = getIntakeSum(for: date)
//        let activityBurn = getActivityBurnSum(for: date)
//        
//        return DailySummary(date: date, balance: intake-activityBurn)
//    }
}
