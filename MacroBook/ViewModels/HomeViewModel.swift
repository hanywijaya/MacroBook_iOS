//
//  HomeViewModel.swift
//  MacroBook
//
//  Created by Hany Wijaya on 07/06/26.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
final class HomeViewModel: ObservableObject {
    
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    let startOfDay = Calendar.current.startOfDay(for: Date())
    let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!
    
    @Published var todayLogs: [Log] = []
    @Published var caloriesToday: Double = 0
    @Published var proteinToday: Double = 0
    @Published var carbsToday: Double = 0
    @Published var fatToday: Double = 0
    @Published var burnToday: Double = 0
    @Published var netCaloriesToday: Double = 0
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
    
    func getTodayIntakeSum(field: String) -> Double {
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
    
    func getTodayActivityBurnSum(field: String) -> Double {
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
    
    private func getTodayIntakes() -> [Intake] {
        let request: NSFetchRequest<Intake> = Intake.fetchRequest()

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
    
    private func getTodayActivityBurns() -> [ActivityBurn] {
        let request: NSFetchRequest<ActivityBurn> = ActivityBurn.fetchRequest()

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
    
    func getTodayLogs() -> [Log] {
        let intakes = getTodayIntakes()
        let activities = getTodayActivityBurns()

        let intakeLogs = makeIntakeLogs(from: intakes)
        let activityLogs = makeActivityBurnLogs(from: activities)

        return (intakeLogs + activityLogs).sorted { $0.timestamp > $1.timestamp }
    }
    
    func loadUser() {
        user = getUser()
    }
    
    func loadTodayLogs() {
        todayLogs = getTodayLogs()
    }
    
    func loadTodayStats() {
        burnToday = getTodayActivityBurnSum(field: "calories")
        caloriesToday = getTodayIntakeSum(field: "calories")
        carbsToday = getTodayIntakeSum(field: "carbs")
        proteinToday = getTodayIntakeSum(field: "protein")
        fatToday = getTodayIntakeSum(field: "fat")
        netCaloriesToday = caloriesToday - burnToday
    }
    
    func refreshDashboard() {
        loadTodayLogs()
        loadTodayStats()
        loadUser()
    }
    
}
