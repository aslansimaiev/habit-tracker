//
//  Habit+Mock.swift
//  Habit Tracker
//
//  Created by NIL on 03.01.2026.
//

import Foundation
extension Habit {

    static func mock() -> Habit {
        // 1️⃣ создаём только Habit
        let habit = Habit(
            title: "Morning Routine",
            subtitle: "Improve my mornings",
            totalSessions: 15,
            daysOfWeek: [.monday, .tuesday, .wednesday, .thursday, .friday]
        )
        habit.completedCount = 5

        // ⚠️ сабтаски добавляем ПОСЛЕ вставки Habit в context
        // habit.subtasks.append(...) делаем только после вставки в Preview

        return habit
    }
}
