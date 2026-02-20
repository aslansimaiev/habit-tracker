//
//  HabitPreset+Mock.swift
//  Habit Tracker
//
//  Created by NIL on 05.01.2026.
//

import Foundation
extension HabitPreset {
    
    static let morningRoutine = HabitPreset(
        title: "Morning Routine",
        subtitle: "Start your day right",
        imageName: "preset_morning",
        totalSessions: 15,
        daysOfWeek: [.monday, .tuesday, .wednesday, .thursday, .friday],
        subtasks: [
            HabitSubtaskPreset(title: "Drink water", duration: nil),
            HabitSubtaskPreset(title: "Stretching", duration: 300),
            HabitSubtaskPreset(title: "Meditation", duration: 600)
        ]
    )
    
    static let eveningWindDown = HabitPreset(
        title: "Evening Wind Down",
        subtitle: "Relax before sleep",
        imageName: "preset_evening",
        totalSessions: 8,
        daysOfWeek: Weekday.allCases,
        subtasks: [
            HabitSubtaskPreset(title: "Read a book", duration: 1800),
            HabitSubtaskPreset(title: "Plan tomorrow", duration: 600)
        ]
    )
    
    static let mockList: [HabitPreset] = [
        .morningRoutine,
        .eveningWindDown
    ]
}
