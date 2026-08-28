//
//  LogDetailViewModel.swift
//  MacroBook
//
//  Created by Hany Wijaya on 29/06/26.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
final class LogDetailViewModel: ObservableObject {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func editLog(log: Log) {
        guard let id = log.id else {return}
        
        do {
            switch log.type {
            case .intake:
                guard let intake = try context.existingObject(with: id) as? Intake else {return}
                
                intake.timestamp = log.timestamp
                intake.title = log.title
                intake.note = log.note
                intake.serving = log.serving ?? 1
                intake.calories = log.calories
                intake.carbs = log.carbs ?? 0
                intake.protein = log.protein ?? 0
                intake.fat = log.fat ?? 0
                
            case .activityBurn:
                guard let activityBurn = try context.existingObject(with: id) as? ActivityBurn else {return}
                
                activityBurn.timestamp = log.timestamp
                activityBurn.title = log.title
                activityBurn.note = log.note
                activityBurn.calories = log.calories
            }
            
            try context.save()
            
        } catch {
            print("Failed to edit log: \(error.localizedDescription)")
        }
    }
    
    func deleteLog(_ log: Log) {
        guard let objectID = log.id else {
            print("No object ID found")
            return
        }

        do {
            let object = try context.existingObject(with: objectID)

            context.delete(object)
            try context.save()

        } catch {
            print("Failed to delete log: \(error)")
        }
    }
}
