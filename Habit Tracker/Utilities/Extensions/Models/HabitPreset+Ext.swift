//
//  HabitPreset+Ext.swift
//  Habit Tracker
//
//  Created by NIL on 11.02.2026.
//

import Foundation
extension HabitPreset {
    func makeDraftHabit() -> Habit {
        let habit = Habit(
            title: title,
            subtitle: subtitle,
            totalSessions: totalSessions,
            daysOfWeek: daysOfWeek
        )

        habit.subtasks = subtasks.map {
            HabitSubtaskTemplate(title: $0.title, duration: $0.duration)
        }

        return habit
    }
}
