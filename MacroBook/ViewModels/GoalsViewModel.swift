//
//  GoalsViewModel.swift
//  MacroBook
//
//  Created by Hany Wijaya on 07/06/26.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
final class GoalsViewModel: ObservableObject {
    
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    @Published var user: User?
    
    func saveGoals(name: String, gender: String, age: String, height: String, weight: String, maintenance: String, targetCarbs: String, targetProtein: String, targetFat: String) {
        
        resetUsers()
        
        let newUser = User(context: context)
        newUser.timestamp = Date()
        newUser.name = name
        newUser.age = Double(age) ?? 0
        newUser.gender = gender
        newUser.height = Double(height) ?? 0
        newUser.weight = Double(weight) ?? 0
//        newUser.activityLevel = Double(activityLevel) ?? 0
//        newUser.sedentary = Double(sedentary) ?? 0
        newUser.maintenance = Double(maintenance) ?? 0
        newUser.targetCarbs = Double(targetCarbs) ?? 0
        newUser.targetProtein = Double(targetProtein) ?? 0
        newUser.targetFat = Double(targetFat) ?? 0
        
        print("\(newUser.name ?? "not saved")")

        do {
            try context.save()
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1

        return try? context.fetch(request).first
    }
    
    func loadUser() {
        user = fetchUser()
    }
    
    func resetUsers() {
        let request: NSFetchRequest<User> = User.fetchRequest()

        do {
            let users = try context.fetch(request)

            for user in users {
                context.delete(user)
            }

            try context.save()

            self.user = nil
        } catch {
            print("Failed to reset users: \(error.localizedDescription)")
        }
    }
}
