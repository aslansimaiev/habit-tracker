//
//  Task+Mock.swift
//  Habit Tracker
//
//  Created by NIL on 04.01.2026.
//

import Foundation
extension Task {

    static let pending = Task(
        id: UUID(),
        template: HabitSubtaskTemplate.stretch,
        status: .pending
    )

    static let inProgress = Task(
        id: UUID(),
        template: HabitSubtaskTemplate.meditation,
        status: .inProgress
    )

    static let completed = Task(
        id: UUID(),
        template: HabitSubtaskTemplate.water,
        status: .completed
    )

    static let mockList: [Task] = [
        .pending,
        .inProgress,
        .completed
    ]
}
