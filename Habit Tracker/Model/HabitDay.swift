//
//  HabitDay.swift
//  Habit Tracker
//
//  Created by NIL on 10.01.2026.
//

import Foundation
struct HabitDay: Identifiable, Codable, Hashable {
    let id: UUID

    // Which habit this day belongs to
    let habitId: UUID

    // Calendar day
    let date: Date

    // Tasks generated from subtask templates
    var tasks: [Task]
}
