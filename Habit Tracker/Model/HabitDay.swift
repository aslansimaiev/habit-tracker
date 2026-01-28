//
//  HabitDay.swift
//  Habit Tracker
//
//  Created by NIL on 10.01.2026.
//

import Foundation
import SwiftData
@Model
class HabitDay: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID

    // Which habit this day belongs to
    @Relationship(deleteRule: .cascade) var habit: Habit

    // Calendar day
    var date: Date

    // Tasks generated from subtask templates
    var tasks: [Task]
    
    
    init(id: UUID, habit: Habit, date: Date, tasks: [Task]) {
        self.id = id
        self.habit = habit
        self.date = date
        self.tasks = tasks
    }
}
