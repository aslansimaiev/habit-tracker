//
//  HabitSubtaskPreset.swift
//  Habit Tracker
//
//  Created by NIL on 02.02.2026.
//

import Foundation
struct HabitSubtaskPreset: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let duration: TimeInterval?
}
