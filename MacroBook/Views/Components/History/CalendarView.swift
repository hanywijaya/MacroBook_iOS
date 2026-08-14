//
//  CalendarView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 04/07/26.
//

import SwiftUI

struct CalendarView: View {
    let days: [DailySummary]
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    @Binding var currentMonth: Date
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    changeMonth(by: -1)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14))
                        .padding(12)
                        .background(.darkBrown)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black.opacity(0.05), radius: 10)
                }
                
                Button {
                    //
                } label: {
                    Text(currentMonth.formatted(.dateTime.month(.wide).year()))
                        .font(.custom("Poppins-Medium", size: 14))
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .black.opacity(0.1), radius: 10)
                }
                
                Button {
                    changeMonth(by: 1)
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .padding(12)
                        .background(.darkBrown)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black.opacity(0.05), radius: 10)
                }
            }
            .foregroundColor(.black)
            
            HStack {
                ForEach(["S", "M", "T", "W", "T", "F", "S"], id: \.self) { day in
                    Text(day)
                        .font(.custom("Poppins-Regular", size: 13))
                        .foregroundColor(.darkGray)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(days) { day in
                    CalendarCellView(day: day)
                }
            }
        }
    }
    
    private func changeMonth(by value: Int) {
        if let month = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = month
        }
    }
}

#Preview {
    AppContainer(color: .backgroundGray) {
        CalendarView(days: [DailySummary(date: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, balance: -300)], currentMonth: .constant(Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!))
            .padding(.horizontal, 16)
    }
}
