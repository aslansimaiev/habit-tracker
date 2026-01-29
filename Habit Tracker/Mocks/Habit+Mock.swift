//
//  Habit+Mock.swift
//  Habit Tracker
//
//  Created by NIL on 03.01.2026.
//

import Foundation
extension Habit {

    static let mock = Habit(
        id: UUID(),
        title: "Morning Routine",
        subtitle: "Improve my mornings",
        totalSessions: 15,
        daysOfWeek: [.monday, .tuesday, .wednesday, .thursday, .friday],
        subtasks: HabitSubtaskTemplate.mockList,
        status: .inProgress,
        completedCount: 5
    )

    static let completedMock = Habit(
        id: UUID(),
        title: "Evening Wind Down",
        subtitle: "Relax before sleep",
        totalSessions: 8,
        daysOfWeek: Weekday.allCases,
        subtasks: [
            HabitSubtaskTemplate(
                id: UUID(),
                title: "Read a book",
                duration: 1800
            ),
            HabitSubtaskTemplate(
                id: UUID(),
                title: "Plan tomorrow",
                duration: 600
            )
        ],
        status: .completed,
        completedCount: 8
    )

    static let mockList: [Habit] = [
        .mock,
        .completedMock
    ]
}
