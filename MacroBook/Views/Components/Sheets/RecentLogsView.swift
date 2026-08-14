//
//  RecentLogsView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 08/07/26.
//

import SwiftUI

struct RecentLogsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var recentLogsVM: RecentLogsViewModel
    
    let type: LogType
    
    @Binding var title: String
    @Binding var date: Date
    @Binding var serving: String
    @Binding var note: String
    
    @Binding var calories: String
    @Binding var carbs: String
    @Binding var protein: String
    @Binding var fat: String
    
    var body: some View {
        VStack {
            ZStack {
                Text("Recent Logs")
                    .font(.system(size: 18))
                    .bold()
                
                HStack {
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18))
                            .foregroundStyle(.black)
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.15))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .padding(.top, 20)
            
            SearchBarView(searchText: $recentLogsVM.searchText)
            
            ScrollView {
                LazyVStack(spacing: 32) {
                    ForEach(recentLogsVM.groupedLogs) { dailyLog in
                        VStack(alignment: .leading, spacing: 16) {
                            if !dailyLog.logs.isEmpty {
                                Text(dailyLog.date.header)
                                    .font(.custom("Poppins-Medium", size: 14))
                                    .padding(.horizontal)
                            }
                            
                            VStack(spacing: 12) {
                                ForEach(dailyLog.logs) { log in
                                    if log.type == type {
                                        Button {
                                            title = log.title
                                            calories = log.type == .intake ? (log.calories / (log.serving ?? 1)).display : log.calories.display
                                            note = log.note ?? ""
                                            carbs = ((log.carbs ?? 0) / (log.serving ?? 1)).display
                                            protein = ((log.protein ?? 0) / (log.serving ?? 1)).display
                                            fat = ((log.fat ?? 0) / (log.serving ?? 1)).display
                                            serving = (log.serving ?? 1).display
                                            dismiss()
                                        } label: {
                                            LogCardView(timestamp: log.timestamp, title: log.title, calories: log.calories, type: log.type, carbs: log.carbs, protein: log.protein, fat: log.fat, serving: log.serving)
                                                .padding(.horizontal)
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .background(.backgroundGray)
    }
}

#Preview {
    RecentLogsView(recentLogsVM: RecentLogsViewModel(context: PersistenceController.shared.container.viewContext), type: .intake, title: .constant(""), date: .constant(Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!), serving: .constant(""), note: .constant(""), calories: .constant(""), carbs: .constant(""), protein: .constant(""), fat: .constant(""))
}
