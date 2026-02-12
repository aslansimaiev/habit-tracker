//
//  HabitPreset+Mock.swift
//  Habit Tracker
//
//  Created by NIL on 05.01.2026.
//

import Foundation

extension HabitPreset {

    // 1) Morning Routine 
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

    // 2) Evening Wind Down
    static let eveningWindDown = HabitPreset(
        title: "Evening Wind Down",
        subtitle: "Relax before sleep",
        imageName: "preset_evening",
        totalSessions: 14,
        daysOfWeek: Weekday.allCases,
        subtasks: [
            HabitSubtaskPreset(title: "Put phone away", duration: nil),
            HabitSubtaskPreset(title: "Read a book", duration: 1200),
            HabitSubtaskPreset(title: "Plan tomorrow", duration: 600)
        ]
    )

    // 3) Deep Work Block
    static let deepWork = HabitPreset(
        title: "Deep Work",
        subtitle: "One focused block a day",
        imageName: "preset_focus",
        totalSessions: 10,
        daysOfWeek: [.monday, .tuesday, .wednesday, .thursday, .friday],
        subtasks: [
            HabitSubtaskPreset(title: "Pick one priority task", duration: nil),
            HabitSubtaskPreset(title: "Focus session", duration: 1500), // 25 min
            HabitSubtaskPreset(title: "Quick review + next step", duration: 300)
        ]
    )

    // 4) Workout
    static let workout = HabitPreset(
        title: "Workout",
        subtitle: "Move your body",
        imageName: "preset_workout",
        totalSessions: 12,
        daysOfWeek: [.monday, .wednesday, .friday],
        subtasks: [
            HabitSubtaskPreset(title: "Warm up", duration: 300),
            HabitSubtaskPreset(title: "Main workout", duration: 1200),
            HabitSubtaskPreset(title: "Cool down stretch", duration: 300)
        ]
    )

    // 5) Home Reset
    static let homeReset = HabitPreset(
        title: "Weekend Home Reset",
        subtitle: "Clean, plan, reset",
        imageName: "preset_home",
        totalSessions: 8,
        daysOfWeek: [.saturday, .sunday],
        subtasks: [
            HabitSubtaskPreset(title: "Tidy one area", duration: 900),
            HabitSubtaskPreset(title: "Laundry / dishes", duration: nil),
            HabitSubtaskPreset(title: "Weekly plan", duration: 600)
        ]
    )

    static let mockList: [HabitPreset] = [
        .morningRoutine,
        .deepWork,
        .workout,
        .eveningWindDown,
        .homeReset
    ]
}
