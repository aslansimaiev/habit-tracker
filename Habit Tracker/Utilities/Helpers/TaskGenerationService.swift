//
//  TaskGenerationService.swift
//  Habit Tracker
//
//  Created by NIL on 12.02.2026.
//

import Foundation
import SwiftData
struct TaskGenerationService {

    static func generateTodayTasksIfNeeded(
        habits: [Habit],
        context: ModelContext
    ) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)

        let weekdayIndex = (calendar.component(.weekday, from: .now) + 5) % 7 + 1
        guard let todayWeekday = Weekday(rawValue: weekdayIndex) else { return }

        let todayHabits = habits.filter {
            $0.daysOfWeek.contains(todayWeekday)
        }

        for habit in todayHabits {
            for subtask in habit.subtasks {
                if !habit.hasTask(for: today, template: subtask) {
                    context.insert(TaskInstance(date: today, habit: habit, template: subtask))
                }
            }
        }

        try? context.save()
    }
}
