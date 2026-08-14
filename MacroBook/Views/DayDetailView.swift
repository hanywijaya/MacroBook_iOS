//
//  DayDetailView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 10/07/26.
//

import SwiftUI

struct DayDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    let date: Date
    
    @ObservedObject var dayDetailVM: DayDetailViewModel
    
    var body: some View {
        AppContainer(color: .cardBackground) {
            VStack {
                ZStack(alignment: .top) {
                    VStack(spacing: 4) {
                        Text("\(Formatter.formatDate(date: date))")
                            .font(.system(size: 16))
                            .bold()
                        Text("\(Formatter.formatDateToDay(date: date))")
                            .font(.system(size: 13))
                            .foregroundColor(.darkBrown)
                    }
                    .padding(.top, 4)
                    
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            ZStack {
                                Image(systemName: "chevron.left")
                                    .bold()
                                    .foregroundColor(.darkBrown)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.black)
                                    .frame(width: 40, height: 40)
                            }
                        }
                        
                        Spacer()
                        
//                        Button {
//                            // Edit action
//                        } label: {
//                            ZStack {
//                                Circle()
//                                    .fill(.darkBrown.opacity(0.1))
//                                    .frame(width: 40, height: 40)
//                                Image(systemName: "ellipsis")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 16)
//                                    .bold()
//                                    .foregroundColor(.darkBrown)
//                            }
//                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 20)
                
                ScrollView {
                    VStack {
                        NetResultCardView(title: "Net calories", netCalories: dayDetailVM.netCalories, intakeCalories: dayDetailVM.calories, burntCalories: dayDetailVM.burn, calorieTarget: dayDetailVM.user?.maintenance ?? 0)
                            .padding(.top, 16)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Macros")
                                .font(.custom("Poppins-Medium", size: 14))
                                .padding(.horizontal, 24)
                            
                            HStack {
                                MacroProgressView(title: "Carbs", macroNow: dayDetailVM.carbs, macroTarget: dayDetailVM.user?.targetCarbs ?? 0)
                                    .frame(width: 105)
                                Spacer()
                                MacroProgressView(title: "Protein", macroNow: dayDetailVM.protein, macroTarget: dayDetailVM.user?.targetProtein ?? 0)
                                    .frame(width: 105)
                                Spacer()
                                MacroProgressView(title: "Fat", macroNow: dayDetailVM.fat, macroTarget: dayDetailVM.user?.targetFat ?? 0)
                                    .frame(width: 105)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                        }
                        .padding(.top, 8)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Logs")
                                .font(.custom("Poppins-Medium", size: 14))
                            
                            VStack {
                                if dayDetailVM.logs.isEmpty {
                                    VStack {
                                        Text("No logs found")
                                            .font(.custom("Poppins-Medium",  size: 13))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        Text("Seems like you didn't log anything this day~")
                                            .font(.custom("Poppins-Regular",  size: 11))
                                            .foregroundColor(.darkGray)
                                    }
                                    .frame(height: 100)
                                    .background(.cardBackground)
                                    .cornerRadius(10)
                                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 0)
                                    
                                } else {
                                    ForEach(dayDetailVM.logs) { log in
                                        NavigationLink {
                                            LogDetailView(log: log)
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
                                }
                            }
                            .padding(.bottom, 16)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            dayDetailVM.loadData(for: date)
        }
    }
}

#Preview {
    DayDetailView(date: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, dayDetailVM: DayDetailViewModel(context: PersistenceController.shared.container.viewContext))
}
