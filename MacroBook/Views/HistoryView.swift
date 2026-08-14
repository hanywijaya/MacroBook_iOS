//
//  HistoryView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 05/06/26.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var historyVM: HistoryViewModel
    
    var body: some View {
        NavigationStack {
            AppContainer(color: .backgroundGray){
                VStack(spacing: 32) {
                    VStack(alignment: .leading) {
                        Text("History")
                            .font(.custom("Poppins-SemiBold", size: 24))
                        Text("Observe your progress over time")
                            .font(.custom("Poppins-Regular", size: 14))
                            .foregroundColor(.darkGray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 52)
                    .padding(.horizontal, 16)
                    
                    ScrollView {
                        HStack {
                            VStack(alignment: .center) {
                                Text("This week")
                                    .font(.custom("Poppins-Regular", size: 11))
                                    .foregroundColor(.darkGray)
                                if historyVM.weeklyBalance <= 0 {
                                    Text("\(historyVM.weeklyBalance.display) kcal")
                                        .font(.custom("Poppins-SemiBold", size: 14))
                                        .foregroundColor(.oliveGreen)
                                } else {
                                    Text("+\(historyVM.weeklyBalance.display) kcal")
                                        .font(.custom("Poppins-SemiBold", size: 14))
                                        .foregroundColor(.coralPink)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .black.opacity(0.1), radius: 7)
                            
                            VStack(alignment: .center) {
                                Text("This month")
                                    .font(.custom("Poppins-Regular", size: 11))
                                    .foregroundColor(.darkGray)
                                if historyVM.monthlyBalance <= 0 {
                                    Text("\(historyVM.monthlyBalance.display) kcal")
                                        .font(.custom("Poppins-SemiBold", size: 14))
                                        .foregroundColor(.oliveGreen)
                                } else {
                                    Text("+\(historyVM.weeklyBalance.display) kcal")
                                        .font(.custom("Poppins-SemiBold", size: 14))
                                        .foregroundColor(.coralPink)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .black.opacity(0.1), radius: 7)
                        }
                        .padding()
                        
                        CalendarView(days: historyVM.calendarDays, currentMonth: $historyVM.currentMonth)
                            .padding(.top, 16)
                            .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)
                }
//                .padding(.horizontal, 16)
                .task {
                    historyVM.computeWeeklyBalance(for: Date())
                    historyVM.computeMonthlyBalance(for: Date())
                }
            }
        }
    }
}

#Preview {
    HistoryView(historyVM: HistoryViewModel(context:  PersistenceController.shared.container.viewContext))
}
