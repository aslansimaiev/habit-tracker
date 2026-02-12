//
//  Task+Mock.swift
//  Habit Tracker
//
//  Created by NIL on 04.01.2026.
//

import Foundation
extension TaskInstance {
    
    static func mock( habit: Habit, template: HabitSubtaskTemplate, date: Date, status: TaskStatus = .completed) -> TaskInstance {
        let task = TaskInstance(
            date: date,
            habit: habit,
            template: template
        )
        task.status = .completed
        return task
    }
}

