//
//  LogRepository.swift
//  MacroBook
//
//  Created by Hany Wijaya on 01/07/26.
//

import Foundation
import CoreData

//class LogRepository {
//    private let context: NSManagedObjectContext
//
//    init(context: NSManagedObjectContext) {
//        self.context = context
//    }
//    
//    private func getIntakes(for date: Date) -> [Intake] {
//        let startOfDay = Calendar.current.startOfDay(for: Date())
//        let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!
//        let request: NSFetchRequest<Intake> = Intake.fetchRequest()
//
//        request.predicate = NSPredicate(
//            format: "timestamp >= %@ AND timestamp < %@",
//            startOfDay as NSDate,
//            startOfTomorrow as NSDate
//        )
//        
//        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
//        
//        do {
//            return try context.fetch(request)
//        } catch {
//            print("Failed to fetch today's intakes:", error)
//            return []
//        }
//    }
//    
//    private func getTodayActivityBurns() -> [ActivityBurn] {
//        let request: NSFetchRequest<ActivityBurn> = ActivityBurn.fetchRequest()
//
//        request.predicate = NSPredicate(
//            format: "timestamp >= %@ AND timestamp < %@",
//            startOfDay as NSDate,
//            startOfTomorrow as NSDate
//        )
//        
//        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
//        
//        do {
//            return try context.fetch(request)
//        } catch {
//            print("Failed to fetch today's activity burns:", error)
//            return []
//        }
//    }
//    
//    private func makeIntakeLogs(from intakes: [Intake]) -> [Log] {
//        intakes.compactMap { intake -> Log? in
//            guard let timestamp = intake.timestamp else {
//                return nil
//            }
//
//            return Log(
//                id: intake.objectID,
//                type: .intake,
//                timestamp: timestamp,
//                title: intake.title ?? "",
//                note: intake.note ?? "",
//                calories: intake.calories,
//                protein: intake.protein,
//                carbs: intake.carbs,
//                fat: intake.fat,
//                serving: intake.serving
//            )
//        }
//    }
//    
//    private func makeActivityBurnLogs(from activityBurns: [ActivityBurn]) -> [Log] {
//        activityBurns.compactMap { activityBurn -> Log? in
//            guard let timestamp = activityBurn.timestamp else {
//                return nil
//            }
//
//            return Log(
//                id: activityBurn.objectID,
//                type: .activityBurn,
//                timestamp: timestamp,
//                title: activityBurn.title ?? "",
//                note: activityBurn.note ?? "",
//                calories: activityBurn.calories,
//                protein: 0,
//                carbs: 0,
//                fat: 0,
//                serving: 0
//            )
//        }
//    }
//    
//    func getTodayLogs() -> [Log] {
//        let intakes = getTodayIntakes()
//        let activities = getTodayActivityBurns()
//
//        let intakeLogs = makeIntakeLogs(from: intakes)
//        let activityLogs = makeActivityBurnLogs(from: activities)
//
//        return (intakeLogs + activityLogs).sorted { $0.timestamp > $1.timestamp }
//    }
//}
