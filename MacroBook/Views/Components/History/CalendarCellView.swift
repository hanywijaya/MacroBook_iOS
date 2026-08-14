//
//  CalendarCellView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 04/07/26.
//

import SwiftUI

struct CalendarCellView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let day: DailySummary
    
    var body: some View {
        if let date = day.date {
            NavigationLink {
                DayDetailView(date: date, dayDetailVM: DayDetailViewModel(context: viewContext))
            } label: {
                VStack(spacing: 2) {
                    Text(date.formatted(.dateTime.day()))
                        .font(.custom("Poppins-SemiBold", size: 13))
                        .foregroundColor(.black)
                    
                    if let balance = day.balance {
                        Text(balance > 0 ? "+\(balance.display)":"\(balance.display)")
                            .font(.custom("Poppins-Medium", size: 10))
                            .foregroundColor(color)
                    }
                }
                .frame(width: 48, height: 48)
                .background(color.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .frame(maxWidth: .infinity)
            }
        } else {
            Color.clear
                .frame(height: 48)
        }
    }
    
    private var color: Color {
            guard let balance = day.balance else {
                return .secondary
            }

            if balance > 0 {
                return .coralPink
            } else if balance == 0 {
                
                guard let date = day.date else {
                    return .secondary
                }
                
                if date.isBeforeToday {
                    return .mustardYellow
                } else {
                    return .secondary
                }
                
            } else {
                return .oliveGreen
            }

        }
}

#Preview {
    HStack(spacing: 0) {
        CalendarCellView(day: DailySummary(date: nil, balance: nil))
        CalendarCellView(day: DailySummary(date: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, balance: 10000))
        CalendarCellView(day: DailySummary(date: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, balance: -300))
        CalendarCellView(day: DailySummary(date: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, balance: -300))
        CalendarCellView(day: DailySummary(date: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, balance: -300))
        CalendarCellView(day: DailySummary(date: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, balance: -300))
        CalendarCellView(day: DailySummary(date: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, balance: -300))
    }
    .padding(.horizontal, 16)
}
