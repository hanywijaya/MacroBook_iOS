//
//  DailyLogs.swift
//  MacroBook
//
//  Created by Hany Wijaya on 08/07/26.
//

import Foundation
import CoreData

struct DailyLogs: Identifiable {
    var id: Date { date }
    let date: Date
    let logs: [Log]
}
