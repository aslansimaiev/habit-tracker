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
        title: "Morning Workout",
        subtitle: "Goal is to work out ",
        totalSessions: 20,
        daysOfWeek: [.monday, .tuesday, .wednesday, .thursday, .friday],
        status: .inProgress,
        completedCount: 7
    )

    static let completedMock = Habit(
        id: UUID(),
        title: "Read 10 Pages",
        subtitle: "Goal is to become smarter",

        totalSessions: 10,
        daysOfWeek: Set(Weekday.allCases),
        status: .completed,
        completedCount: 10
    )

    static let mockList: [Habit] = [
        .mock,
        .completedMock,
        Habit(
            id: UUID(),
            title: "Meditation",
            subtitle: "Goal is to calm yourself",

            totalSessions: 30,
            daysOfWeek: [.saturday, .sunday],
            status: .inProgress,
            completedCount: 3
        )
    ]
}
