//
//  AddIntakeViewModel.swift
//  MacroBook
//
//  Created by Hany Wijaya on 10/06/26.
//

import Foundation
import CoreData

@MainActor
final class AddIntakeViewModel: ObservableObject {
    
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addIntake(title: String, date: Date, serving: String, note: String?, calories: String, carbs: String, protein: String, fat: String) {
        let newIntake = Intake(context: context)
        newIntake.title = title
        newIntake.timestamp = date
        newIntake.serving = Double(serving) ?? 1
        newIntake.note = note
        newIntake.calories = (Double(calories) ?? 0) * newIntake.serving
        newIntake.carbs = (Double(carbs) ?? 0) * newIntake.serving
        newIntake.protein = (Double(protein) ?? 0) * newIntake.serving
        newIntake.fat = (Double(fat) ?? 0) * newIntake.serving
        
        do {
            try context.save()
            print("Saved successfully: \(newIntake.title)")
        } catch {
            print("Failed to save intake: \(error.localizedDescription)")
        }
    }
}
