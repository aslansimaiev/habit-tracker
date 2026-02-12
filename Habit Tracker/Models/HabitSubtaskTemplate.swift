//
//  HabitSubtaskTemplate.swift
//  Habit Tracker
//
//  Created by NIL on 10.01.2026.
//
import Foundation
import SwiftData

@Model
final class HabitSubtaskTemplate {
    var title: String
    // Timer duration (nil = no timer)
    var duration: TimeInterval?
    @Relationship
    var habit: Habit?
    var id: UUID = UUID()
    init(title: String, duration: TimeInterval? = nil, habit: Habit? = nil) {
        self.title = title
        self.duration = duration
        self.habit = habit
    }
}
