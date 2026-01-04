//
//  Task+Mock.swift
//  Habit Tracker
//
//  Created by NIL on 04.01.2026.
//

import Foundation
extension Task {

    static let mock = Task(
        id: UUID(),
        title: "Drink a glass of water",
        time: Calendar.current.date(
            bySettingHour: 9,
            minute: 0,
            second: 0,
            of: Date()
        ),
        duration: 300, // 5 minutes
        status: .pending
    )

    static let completedMock = Task(
        id: UUID(),
        title: "Morning stretch",
        time: Calendar.current.date(
            bySettingHour: 7,
            minute: 30,
            second: 0,
            of: Date()
        ),
        duration: 600, // 10 minutes
        status: .completed
    )

    static let mockList: [Task] = [
        .mock,
        .completedMock,
        Task(
            id: UUID(),
            title: "Meditation",
            time: nil,          // no fixed time
            duration: 900,      // 15 minutes
            status: .pending
        )
    ]
}
