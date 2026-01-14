//
//  WeekStat.swift
//  Habit Tracker
//
//  Created by NIL on 07.01.2026.
//

import Foundation

struct WeekStat: Identifiable {
    let id = UUID()
    let day: Weekday
    let value: Int
}
