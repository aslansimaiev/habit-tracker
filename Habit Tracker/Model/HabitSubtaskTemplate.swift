//
//  HabitSubtaskTemplate.swift
//  Habit Tracker
//
//  Created by NIL on 10.01.2026.
//

import SwiftUI
struct HabitSubtaskTemplate: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String

    // Timer duration (nil = no timer)
    var duration: TimeInterval?
}
