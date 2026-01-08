//
//  WeekDay+Ext.swift
//  Habit Tracker
//
//  Created by NIL on 07.01.2026.
//

import Foundation
extension Weekday {
    var short: String {
        switch self {
        case .monday: return "Mon"
        case .tuesday: return "Tue"
        case .wednesday: return "Wed"
        case .thursday: return "Thu"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        case .sunday: return "Sun"
        }
    }
}
