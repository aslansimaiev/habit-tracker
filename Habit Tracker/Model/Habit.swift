//
//  Habit.swift
//  Habit Tracker
//
//  Created by NIL on 03.01.2026.
//

import Foundation

struct Habit: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String

    // Total number of required completions
    let totalSessions: Int
    // Days when the habit is active
    let daysOfWeek: Set<Weekday>
    
    //let subtasks:
    
    //Overall habit lifecycle status
    let status: HabitStatus
    //Temporary Until task is implemented
    var completedCount: Int = 0
    //progress from 0.0 to 1.0
    var progress: Double {
        guard totalSessions > 0 else { return 0 }
        return Double(completedCount) / Double(totalSessions)
    }
}

//MARK: - Weekday to track when habit tasks should be completed.
enum Weekday: Int, CaseIterable, Codable, Hashable {
    case monday = 1
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

//MARK: - Current status of habit completion
enum HabitStatus: String, Codable {
    case inProgress
    case completed
}
