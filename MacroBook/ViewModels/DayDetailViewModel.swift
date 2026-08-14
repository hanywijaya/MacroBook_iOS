//
//  DayDetailViewModel.swift
//  MacroBook
//
//  Created by Hany Wijaya on 10/07/26.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
final class DayDetailViewModel: ObservableObject {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    @Published var logs: [Log] = []
    @Published var calories: Double = 0
    @Published var protein: Double = 0
    @Published var carbs: Double = 0
    @Published var fat: Double = 0
    @Published var burn: Double = 0
    @Published var netCalories: Double = 0
    @Published var user: User?
    
    func getUser() -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1

        do {
            return try context.fetch(request).first
        } catch {
            print(error)
            return nil
        }
    }
    
    func getIntakeSum(for date: Date, field: String) -> Double {
        let request = NSFetchRequest<NSDictionary>(entityName: "Intake")
        let startOfDay = Calendar.current.startOfDay(for: date)
        let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: date))!

        request.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@",
            startOfDay as NSDate,
            startOfTomorrow as NSDate
        )

        let expression = NSExpressionDescription()
        expression.name = "total"
        expression.expression = NSExpression(
            forFunction: "sum:",
            arguments: [NSExpression(forKeyPath: field)]
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
    
    func getActivityBurnSum(date: Date, field: String) -> Double {
        let request = NSFetchRequest<NSDictionary>(entityName: "ActivityBurn")
        let startOfDay = Calendar.current.startOfDay(for: date)
        let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: date))!
        
        request.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@",
            startOfDay as NSDate,
            startOfTomorrow as NSDate
        )
        
        let expression = NSExpressionDescription()
        expression.name = "total"
        expression.expression = NSExpression(
            forFunction: "sum:",
            arguments: [NSExpression(forKeyPath: field)]
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
    
    private func getIntakes(for date: Date) -> [Intake] {
        let request: NSFetchRequest<Intake> = Intake.fetchRequest()
        let startOfDay = Calendar.current.startOfDay(for: date)
        let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: date))!

        request.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@",
            startOfDay as NSDate,
            startOfTomorrow as NSDate
        )
        
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch today's intakes:", error)
            return []
        }
    }
    
    private func getActivityBurns(for date: Date) -> [ActivityBurn] {
        let request: NSFetchRequest<ActivityBurn> = ActivityBurn.fetchRequest()
        let startOfDay = Calendar.current.startOfDay(for: date)
        let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: date))!

        request.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@",
            startOfDay as NSDate,
            startOfTomorrow as NSDate
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
    
    func getLogs(for date: Date) -> [Log] {
        let intakes = getIntakes(for: date)
        let activities = getActivityBurns(for: date)

        let intakeLogs = makeIntakeLogs(from: intakes)
        let activityLogs = makeActivityBurnLogs(from: activities)

        return (intakeLogs + activityLogs).sorted { $0.timestamp > $1.timestamp }
    }
    
    func loadData(for date: Date) {
        user = getUser()
        logs = getLogs(for: date)
        burn = getActivityBurnSum(date: date, field: "calories")
        calories = getIntakeSum(for: date, field: "calories")
        carbs = getIntakeSum(for: date, field: "carbs")
        protein = getIntakeSum(for: date, field: "protein")
        fat = getIntakeSum(for: date, field: "fat")
        netCalories = calories - burn
    }
}
