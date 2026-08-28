//
//  ContentView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 03/06/26.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showAddIntake = false
    @State private var showAddActivityBurn = false
    @State private var showEditGoals = false
    @State private var showMenu = false
    @State private var selectedTab = 0
    
    @ObservedObject var homeVM: HomeViewModel
    
    var body: some View {
        NavigationStack {
            AppContainer(color: .backgroundGray) {
                VStack(spacing: 32) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(Date.now, format: .dateTime.weekday(.abbreviated).day().month(.abbreviated).year())
                                .font(.custom("Poppins-SemiBold", size: 24))
                            Text("Start tracking your macros today!")
                                .font(.custom("Poppins-Regular", size: 14))
                                .foregroundColor(.darkGray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 52)
                        
                        Button {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                showMenu.toggle()
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(.darkBrown.opacity(0.1))
                                    .frame(width: 40, height: 40)
                                Image(systemName: "plus")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 14)
                                    .bold()
                                    .foregroundColor(.darkBrown)
                            }
                            .rotationEffect(.degrees(showMenu ? 45 : 0))
                            .padding(.top, 8)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    ScrollView {
                        VStack(spacing: 32) {
                            NetCaloriesCardView(title: "Net calories today", netCalories: homeVM.netCaloriesToday, intakeCalories: homeVM.caloriesToday, burntCalories: homeVM.burnToday, calorieTarget: homeVM.getUser()?.maintenance ?? 0, showAddIntake: $showAddIntake)
                                .padding(.bottom, -16)
                                .padding(.top, -8)
                            
                            VStack(alignment: .leading, spacing: 20) {
                                HStack(alignment: .bottom) {
                                    Text("Macros today")
                                        .font(.custom("Poppins-Medium", size: 14))
                                    Spacer()
                                    Button {
                                        showEditGoals = true
                                    } label: {
                                        Text("Edit goals >")
                                            .font(.custom("Poppins-Medium", size: 12))
                                            .foregroundColor(.oliveGreen)
                                    }
                                }
                                
                                
                                HStack {
                                    MacroProgressView(title: "Carbs", macroNow: homeVM.carbsToday, macroTarget: homeVM.getUser()?.targetCarbs ?? 100)
                                        .frame(width: 105)
                                    Spacer()
                                    MacroProgressView(title: "Protein", macroNow: homeVM.proteinToday, macroTarget: homeVM.getUser()?.targetProtein ?? 100)
                                        .frame(width: 105)
                                    Spacer()
                                    MacroProgressView(title: "Fat", macroNow: homeVM.fatToday, macroTarget: homeVM.getUser()?.targetFat ?? 100)
                                        .frame(width: 105)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Logs today")
                                    .font(.custom("Poppins-Medium", size: 14))
                                
                                VStack {
                                    if homeVM.todayLogs.isEmpty {
                                        VStack {
                                            Text("No logs yet")
                                                .font(.custom("Poppins-Medium",  size: 13))
                                                .frame(maxWidth: .infinity, alignment: .center)
                                            Text("Start logging your intakes and activities!")
                                                .font(.custom("Poppins-Regular",  size: 11))
                                                .foregroundColor(.darkGray)
                                        }
                                        .frame(height: 100)
                                        .background(.cardBackground)
                                        .cornerRadius(10)
                                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 0)
                                        
                                    } else {
                                        ForEach(homeVM.todayLogs) { log in
                                            NavigationLink {
                                                LogDetailView(log: log, logDetailVM: LogDetailViewModel(context: viewContext))
                                            } label: {
                                                LogCardView(
                                                    timestamp: log.timestamp,
                                                    title: log.title,
                                                    calories: log.calories,
                                                    type: log.type,
                                                    carbs: log.carbs ?? 0,
                                                    protein: log.protein ?? 0,
                                                    fat: log.fat ?? 0,
                                                    serving: log.serving ?? 1
                                                )
                                                .foregroundColor(.black)
                                            }
                                        }
                                        
//                                        List {
//                                            ForEach(homeVM.todayLogs) { log in
//                                                NavigationLink {
//                                                    LogDetailView(log: log)
//                                                } label: {
//                                                    LogCardView(
//                                                        timestamp: log.timestamp,
//                                                        title: log.title,
//                                                        calories: log.calories,
//                                                        type: log.type,
//                                                        carbs: log.carbs ?? 0,
//                                                        protein: log.protein ?? 0,
//                                                        fat: log.fat ?? 0,
//                                                        serving: log.serving ?? 1
//                                                    )
//                                                    .foregroundStyle(.black)
//                                                }
//                                                .listRowInsets(
//                                                    EdgeInsets(
//                                                        top: 6,
//                                                        leading: 0,
//                                                        bottom: 6,
//                                                        trailing: 0
//                                                    )
//                                                )
//                                                .listRowBackground(Color.clear)
//                                                .listRowSeparator(.hidden)
//                                            }
//                                            .onDelete { indexSet in
//                                                for index in indexSet {
//                                                    let log = homeVM.todayLogs[index]
//                                                    homeVM.deleteLog(log)
//                                                }
//                                            }
//                                        }
//                                        .listStyle(.plain)
//                                        .scrollContentBackground(.hidden)
//                                        .background(.backgroundGray)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                            .padding(.bottom, 16)
                        }
                        
                    }
                    .scrollIndicators(.hidden)
                }
                .fullScreenCover(isPresented: $showAddIntake) {
                    AddIntakeView(addIntakeVM: AddIntakeViewModel(context: viewContext), homeVM: homeVM)
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                }
                .fullScreenCover(isPresented: $showAddActivityBurn) {
                    AddActivityBurnView(addActivityVM: AddActivityViewModel(context: viewContext), homeVM: homeVM)
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                }
                .fullScreenCover(isPresented: $showEditGoals) {
                    EditGoalsView(goalsVM: GoalsViewModel(context: viewContext), homeVM: homeVM)
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                }
                .task {
                    homeVM.refreshDashboard()
                }
                
                if showMenu {
                    Color.black.opacity(0.0001)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                showMenu = false
                            }
                        }
                }
                
                if showMenu {
                    VStack(spacing: 0) {
                        MenuRowView(icon: "fork.knife", title: "Add Intake") {
                            showAddIntake = true
                            showMenu = false
                        }
                        Divider()
                        MenuRowView(icon: "figure.run", title: "Add Activity Burn") {
                            showAddActivityBurn = true
                            showMenu = false
                        }
                        Divider()
                        MenuRowView(icon: "slider.horizontal.3", title: "Edit Goals") {
                            showEditGoals = true
                            showMenu = false
                        }
                    }
                    .frame(width: 240)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.gray.opacity(0.5) ,radius: 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(.top, 60)
                    .padding(.trailing, 20)
                    .transition(.scale(scale: 0.3, anchor: .topTrailing).combined(with: .opacity))
                }
            }
        }
    }
}

#Preview {
    HomeView(homeVM: HomeViewModel(context:  PersistenceController.shared.container.viewContext))
}
