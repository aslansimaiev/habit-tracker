//
//  Habit.swift
//  Habit Tracker
//
//  Created by NIL on 03.01.2026.
//

import Foundation
import SwiftData
@Model
class Habit: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    var title: String
    var subtitle: String
    // Total number of required completions
    var totalSessions: Int
    // Days when the habit is active
    var daysOfWeek: Set<Weekday>
    
    //let subtasks:
    @Relationship(deleteRule: .cascade) var subtasks: [HabitSubtaskTemplate]
    //Overall habit lifecycle status
    var status: HabitStatus
    //Temporary Until task is implemented
    var completedCount: Int = 0
    //progress from 0.0 to 1.0
    var progress: Double {
        guard totalSessions > 0 else { return 0 }
        return Double(completedCount) / Double(totalSessions)
    }
    var progressPercentage: Int {
        return Int(progress * 100)
    }
    
    var habitDaysLeft: Int {
        return totalSessions - completedCount
    }
    
    init(id: UUID, title: String, subtitle: String, totalSessions: Int, daysOfWeek: Set<Weekday>, subtasks: [HabitSubtaskTemplate], status: HabitStatus, completedCount: Int = 0) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.totalSessions = totalSessions
        self.daysOfWeek = daysOfWeek
        self.subtasks = subtasks
        self.status = status
        self.completedCount = completedCount
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
