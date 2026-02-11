//
//  Ефіл.swift
//  Habit Tracker
//
//  Created by NIL on 04.01.2026.
//

import Foundation
import SwiftData

@Model
final class TaskInstance {
    // MARK: - Core
    var date: Date
    var status: TaskStatus = TaskStatus.pending
    
    // MARK: - Timer state (persisted)
    /// When the current session was started (nil if not running or paused)
    var startedAt: Date?
    
    /// How many seconds have already been "worked" in previous sessions (before pause/restart)
    var accumulatedSeconds: Double = 0
    
    /// How many seconds are needed in total (taken from template.duration, but keep a snapshot at the time of creation)
    /// so that template changes don't break an already created task.
    var targetSeconds: Double?
    
    // MARK: - Relationships
    @Relationship var template: HabitSubtaskTemplate
    @Relationship var habit: Habit
    
    init(date: Date, habit: Habit, template: HabitSubtaskTemplate) {
        self.date = Calendar.current.startOfDay(for: date)
        self.habit = habit
        self.template = template
        self.targetSeconds = template.duration
    }
}
enum TaskStatus: String, Codable {
    case pending
    case inProgress
    case paused
    case completed
}
