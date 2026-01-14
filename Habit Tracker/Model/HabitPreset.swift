//
//  HabitPresets.swift
//  Habit Tracker
//
//  Created by NIL on 05.01.2026.
//

import Foundation

struct HabitPreset: Identifiable, Codable, Hashable {
    let id: UUID
    let habit: Habit
    let imageName: String
}
