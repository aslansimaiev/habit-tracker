//
//  HabitPreset+Mock.swift
//  Habit Tracker
//
//  Created by NIL on 05.01.2026.
//

import Foundation
extension HabitPreset {

    static let running = HabitPreset(
        id: UUID(),
        habit: Habit(
            id: UUID(),
            title: "Running",
            subtitle: "Build endurance",
            totalSessions: 5,
            daysOfWeek: [.monday, .wednesday, .friday],
            subtasks: [],
            status: .inProgress
        ),
        imageName: "preset_running"
    )

    static let cardio = HabitPreset(
        id: UUID(),
        habit: Habit(
            id: UUID(),
            title: "Cardio",
            subtitle: "Stay active",
            totalSessions: 4,
            daysOfWeek: [.tuesday, .thursday, .saturday],
            subtasks: [],
            status: .inProgress
        ),
        imageName: "preset_cardio"
    )

    static let fitness = HabitPreset(
        id: UUID(),
        habit: Habit(
            id: UUID(),
            title: "Fitness",
            subtitle: "Strength & mobility",
            totalSessions: 6,
            daysOfWeek: Set(Weekday.allCases),
            subtasks: [],
            status: .inProgress
        ),
        imageName: "preset_fitness"
    )

    static let mockList: [HabitPreset] = [
        .running,
        .cardio,
        .fitness
    ]
}
