//
//  Habit.swift
//  Habit Tracker
//
//  Created by NIL on 03.01.2026.
//

import Foundation
import SwiftData
@Model
final class Habit {
    // MARK: - Core data
    var title: String
    var subtitle: String
    var totalSessions: Int
    var daysOfWeek: [Weekday]
    
    var status: HabitStatus = HabitStatus.inProgress
    var completedCount: Int = 0 {
        didSet {
            progressValue = totalSessions > 0 ? Double(completedCount) / Double(totalSessions) : 0
        }
    }
    var progressValue: Double = 0.0
    
    // MARK: - Relationships
    
    @Relationship(deleteRule: .cascade, inverse: \HabitSubtaskTemplate.habit)
    var subtasks: [HabitSubtaskTemplate] = []
    
    @Relationship(deleteRule: .cascade, inverse: \TaskInstance.habit)
    var taskInstances: [TaskInstance] = []
    
    // MARK: - Init
    init(
        title: String,
        subtitle: String,
        totalSessions: Int,
        daysOfWeek: [Weekday]
    ) {
        self.title = title
        self.subtitle = subtitle
        self.totalSessions = totalSessions
        self.daysOfWeek = daysOfWeek
    }
}

//MARK: - Weekday to track when habit tasks should be completed.
enum Weekday: Int, CaseIterable, Codable, Hashable {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}


//MARK: - Current status of habit completion
enum HabitStatus: String, Codable {
    case inProgress
    case completed
}
