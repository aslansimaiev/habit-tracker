//
//  HabitSubtaskTemplate.swift
//  Habit Tracker
//
//  Created by NIL on 10.01.2026.
//

import SwiftUI
import SwiftData
@Model
class HabitSubtaskTemplate: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    var title: String

    // Timer duration (nil = no timer)
    var duration: TimeInterval?
    init(id: UUID, title: String, duration: TimeInterval? = nil) {
        self.id = id
        self.title = title
        self.duration = duration
    }
}
