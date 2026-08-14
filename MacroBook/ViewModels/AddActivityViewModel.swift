//
//  AddActivityViewModel.swift
//  MacroBook
//
//  Created by Hany Wijaya on 25/06/26.
//

import Foundation
import CoreData

@MainActor
final class AddActivityViewModel: ObservableObject {
    
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addActivityBurn(title: String, date: Date, note: String?, calories: String) {
        let newActivityBurn = ActivityBurn(context: context)
        newActivityBurn.title = title
        newActivityBurn.timestamp = date
        newActivityBurn.note = note
        newActivityBurn.calories = Double(calories) ?? 0
        
        do {
            try context.save()
            print("Saved successfully: \(newActivityBurn.title)")
        } catch {
            print("Failed to save intake: \(error.localizedDescription)")
        }
    }
}
