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
    var date: Date
    var status: TaskStatus = TaskStatus.pending

    @Relationship
    var template: HabitSubtaskTemplate

    @Relationship
    var habit: Habit

    init(date: Date, habit: Habit, template: HabitSubtaskTemplate) {
        self.date = Calendar.current.startOfDay(for: date)
        self.habit = habit
        self.template = template
    }
}

enum TaskStatus: String, Codable {
    case pending
    case inProgress
    case completed
}
