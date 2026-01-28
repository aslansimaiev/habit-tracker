//
//  WeekStat.swift
//  Habit Tracker
//
//  Created by NIL on 07.01.2026.
//

import Foundation
import SwiftData
@Model
class WeekStat: Identifiable {
    var id = UUID()
    var day: Weekday
    var value: Int
    init(id: UUID = UUID(), day: Weekday, value: Int) {
        self.id = id
        self.day = day
        self.value = value
    }
}
