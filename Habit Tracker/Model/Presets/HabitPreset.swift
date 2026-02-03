//
//  HabitPresets.swift
//  Habit Tracker
//
//  Created by NIL on 05.01.2026.
//

import Foundation

struct HabitPreset: Identifiable, Hashable {
    let id = UUID()

    let title: String
    let subtitle: String
    let imageName: String

    let totalSessions: Int
    let daysOfWeek: [Weekday]

    let subtasks: [HabitSubtaskPreset]
}

