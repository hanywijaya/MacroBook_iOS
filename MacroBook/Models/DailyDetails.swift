//
//  DailyDetails.swift
//  MacroBook
//
//  Created by Hany Wijaya on 01/07/26.
//

import Foundation
import CoreData

struct DailyDetails {
    let date: Date
    let netIntake: Double
    let netBurn: Double
    let netCalories: Double
    let balance: Double
    let logs: [Log]?
}
