//
//  Date+Extensions.swift
//  MacroBook
//
//  Created by Hany Wijaya on 06/07/26.
//
import Foundation

extension Date {
    var isBeforeToday: Bool {
        Calendar.current.startOfDay(for: self) <
            Calendar.current.startOfDay(for: Date())
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.range(of: .day, in: .month, for: self)?.count ?? 0
    }
    
    var header: String {
        let calendar = Calendar.current

        if calendar.isDateInToday(self) {
            return "Today"
        }

        if calendar.isDateInYesterday(self) {
            return "Yesterday"
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM yyyy"

        return formatter.string(from: self)
    }
}
