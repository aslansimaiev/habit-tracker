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
        templateId: HabitSubtaskTemplate.stretch.id,
        status: .pending
    )

    static let inProgress = Task(
        id: UUID(),
        templateId: HabitSubtaskTemplate.meditation.id,
        status: .inProgress
    )

    static let completed = Task(
        id: UUID(),
        templateId: HabitSubtaskTemplate.water.id,
        status: .completed
    )

    static let mockList: [Task] = [
        .pending,
        .inProgress,
        .completed
    ]
}
