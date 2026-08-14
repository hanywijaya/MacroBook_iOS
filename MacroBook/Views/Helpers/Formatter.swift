//
//  Formatter.swift
//  MacroBook
//
//  Created by Hany Wijaya on 29/06/26.
//

import SwiftUI

struct Formatter {
    
    static func formatEmptyNote(text: String) -> String{
        if text == "" {
            return "-"
        } else {
            return text
        }
    }
    
    static func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    static func formatDateWithDay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    static func formatDateToDay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    
    static func formatTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
}
