//
//  HabitPresets.swift
//  Habit Tracker
//
//  Created by NIL on 05.01.2026.
//

import Foundation
import SwiftData
@Model
class HabitPreset: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .cascade) var habit: Habit
    var imageName: String
    init(id: UUID, habit: Habit, imageName: String) {
        self.id = id
        self.habit = habit
        self.imageName = imageName
    }
}
