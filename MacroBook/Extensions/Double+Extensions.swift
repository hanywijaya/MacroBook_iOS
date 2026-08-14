//
//  Double+Extensions.swift
//  MacroBook
//
//  Created by Hany Wijaya on 30/06/26.
//

import Foundation

extension Double {
    var display: String {
        rounded().formatted(.number.grouping(.never))
    }
    
    var displayWithDecimal: String {
        formatted(.number.grouping(.never).precision(.fractionLength(0...2)))
    }
}
