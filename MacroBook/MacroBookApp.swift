//
//  MacroBookApp.swift
//  MacroBook
//
//  Created by Hany Wijaya on 03/06/26.
//

import SwiftUI

@main
struct MacroBookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
