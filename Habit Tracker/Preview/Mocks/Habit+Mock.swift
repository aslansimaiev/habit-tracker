//
//  Habit+Mock.swift
//  Habit Tracker
//
//  Created by NIL on 03.01.2026.
//

import Foundation
extension Habit {

    static func mock() -> Habit {

        let habit = Habit(
            title: "Morning Routine",
            subtitle: "Improve my mornings",
            totalSessions: 15,
            daysOfWeek: [.monday, .tuesday, .wednesday, .thursday, .friday]
        )

        return habit
    }
}
