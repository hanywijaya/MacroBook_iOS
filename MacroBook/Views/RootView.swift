//
//  RootView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 05/06/26.
//

import SwiftUI
import CoreData

enum Tabs {
    case home, history
}

struct RootView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var selectedTab: Tabs = .home
    @FetchRequest(entity: User.entity(), sortDescriptors: []) private var users: FetchedResults<User>
    
    var body: some View {
        Group {
            if users.isEmpty {
                OnboardingView(goalsVM: GoalsViewModel(context: viewContext))
            } else {
                TabView(selection: $selectedTab) {
                    Tab("Home", systemImage: "house", value: Tabs.home) {
                        HomeView(homeVM: HomeViewModel(context: viewContext))
                    }
                    
                    Tab("History", systemImage: "magnifyingglass", value: Tabs.history) {
                        HistoryView(historyVM: HistoryViewModel(context: viewContext))
                    }
                }
            }
        }
    }
}

#Preview {
    RootView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
