//
//  LogDetailView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 28/06/26.
//

import SwiftUI

struct LogDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State var log: Log
    
    @State private var showEditIntake: Bool = false
    
    var body: some View {
        AppContainer(color: .cardBackground) {
            VStack {
                ZStack {
                    Text("Log Details")
                        .font(.system(size: 18))
                        .bold()
                    
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
                    VStack() {
                        ZStack {
                            Circle()
                                .fill(.darkBrown.opacity(0.1))
                                .frame(width: 60)
                            
                            Image(systemName: log.type == .intake ? "fork.knife": "figure.run")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                                .bold()
                                .foregroundColor(.darkBrown.opacity(0.8))
                        }
                        .padding(.top, 20)
                        
                        Text(log.title)
                            .font(.custom("Poppins-SemiBold", size: 24))
                            .foregroundColor(.darkBrown)
                        
                        HStack {
                            Text("\(Formatter.formatDate(date: log.timestamp)) • \(Formatter.formatTime(date: log.timestamp)) ")
                                .font(.custom("Poppins-Regular", size: 11))
                                .foregroundColor(.darkGray)
                        }
                    }
                    
                    if log.type == .intake {
                        IntakeDetailView(log: log)
                    } else {
                        ActivityBurnDetailView(log: log)
                    }
                }
                .scrollIndicators(.hidden)
                
                Spacer()
                
                Button {
                    showEditIntake = true
                } label: {
                    Text("Edit log")
                        .font(.custom("Poppins-Bold", size: 14))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(.darkBrown)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                .padding(.bottom, 16)
            }
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $showEditIntake) {
            if log.type == .intake {
                EditIntakeView(log: $log, title: log.title, date: log.timestamp, serving: (log.serving ?? 0).display, note: log.note ?? "", calories: log.calories.display, carbs: (log.carbs ?? 0).display, protein: (log.protein ?? 0).display, fat: (log.fat ?? 0).display, logDetailVM: LogDetailViewModel(context: viewContext), homeVM: HomeViewModel(context: viewContext))
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            } else if log.type == .activityBurn {
                EditActivityBurnView(log: $log, title: log.title, date: log.timestamp, note: log.note ?? "", calories: log.calories.display, logDetailVM: LogDetailViewModel(context: viewContext), homeVM: HomeViewModel(context: viewContext))
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        LogDetailView(log: Log(id: nil, type: .intake, timestamp: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, title: "Milk", note: "200ml", calories: 60, protein: 6, carbs: 9, fat: 0, serving: 1))
//        LogDetailView(log: Log(id: nil, type: .activityBurn, timestamp: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, title: "15k steps", note: "", calories: 300, protein: 0, carbs: 0, fat: 0, serving: 0))
    }
}
