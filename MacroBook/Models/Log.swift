//
//  Log.swift
//  MacroBook
//
//  Created by Hany Wijaya on 10/06/26.
//

import Foundation
import CoreData

enum LogType {
    case intake
    case activityBurn
}

struct Log: Identifiable {
    let id: NSManagedObjectID?
    let type: LogType

    let timestamp: Date
    let title: String
    let note: String?
    
    let calories: Double

    let protein: Double?
    let carbs: Double?
    let fat: Double?
    let serving: Double?
}
