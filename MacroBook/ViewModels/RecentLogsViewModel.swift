//
//  RecentLogsViewModel.swift
//  MacroBook
//
//  Created by Hany Wijaya on 08/07/26.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
final class RecentLogsViewModel: ObservableObject {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    var groupedLogs: [DailyLogs] {
        let calendar = Calendar.current

        let allLogs = getAllLogs(in: DateInterval(start: .distantPast, end: Date()))

        let grouped = Dictionary(grouping: allLogs) {
            calendar.startOfDay(for: $0.timestamp)
        }

        return grouped
            .map {
                DailyLogs(
                    date: $0.key,
                    logs: $0.value.sorted { $0.timestamp > $1.timestamp }
                )
            }
            .sorted { $0.date > $1.date }
    }
    
    @Published var searchText = ""
    
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

        let allLogs = (intakeLogs + activityLogs).sorted { $0.timestamp > $1.timestamp }
        
        if searchText.isEmpty {
            return allLogs
        }
        
        return allLogs.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }
}
