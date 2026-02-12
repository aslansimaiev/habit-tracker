//
//  Weekday.swift
//  Habit Tracker
//
//  Created by NIL on 05.02.2026.
//

import Foundation
//MARK: - Weekday to track when habit tasks should be completed.
enum Weekday: Int, CaseIterable, Codable, Hashable {
    case monday = 1
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}
