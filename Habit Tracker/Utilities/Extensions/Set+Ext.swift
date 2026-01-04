//
//  Set+Ext.swift
//  Habit Tracker
//
//  Created by NIL on 04.01.2026.
//

import Foundation
extension Set where Element == Weekday {
    
    var shortDayList: String {
        let allDays: [Weekday] = Weekday.allCases
        
        // If all days are present, return "Everyday"
        if allDays.allSatisfy(self.contains) {
            return "Everyday"
        }
        
        // Otherwise, return short names
        let symbols = Calendar.current.shortWeekdaySymbols // ["Sun","Mon",...]
        
        // Map weekday rawValue (1 = Monday?) to symbol
        let orderedShortNames = Weekday.allCases.compactMap { day -> String? in
            self.contains(day) ? symbols[day.rawValue % 7] : nil
        }
        
        return orderedShortNames.joined(separator: " • ")
    }
}
