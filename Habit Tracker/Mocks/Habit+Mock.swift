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
        subtitle: "Goal to improve my morning routine",
        
        totalSessions: 15,
        daysOfWeek: [.monday, .tuesday, .wednesday, .thursday, .friday],
        subtasks: [
            Task.mock,
            Task.completedMock,
            Task(
                id: UUID(),
                title: "Write daily goals",
                time: nil,
                duration: nil,
                status: .pending
            )
        ],
        status: .inProgress,
        completedCount: 5
    )

    static let completedMock = Habit(
        id: UUID(),
        title: "Evening Wind Down",
        subtitle: "Goal to manage evening",
        totalSessions: 8,
        daysOfWeek: Set(Weekday.allCases),
        subtasks: [
            Task(
                id: UUID(),
                title: "Read a book",
                time: nil,
                duration: 1800,
                status: .completed
            ),
            Task(
                id: UUID(),
                title: "Plan tomorrow",
                time: nil,
                duration: 600,
                status: .completed
            )
        ],
        status: .completed
    )

    static let mockList: [Habit] = [
        .mock,
        .completedMock
    ]
}
