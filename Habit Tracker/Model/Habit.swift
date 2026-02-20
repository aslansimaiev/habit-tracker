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
    
    @Transient var completedTasksCount: Int {
        taskInstances.filter { $0.status == .completed }.count
    }
    
    @Transient var completedDaysCount: Int {
        let calendar = Calendar.current

        let completedDates = taskInstances
            .filter { $0.status == .completed }
            .map { calendar.startOfDay(for: $0.date) }

        return Set(completedDates).count
    }
    @Transient var progressValue: Double {
        totalSessions > 0 ? Double(completedDaysCount) / Double(totalSessions) : 0
    }

    @Transient var progressPercentage: Int {
        Int(progressValue * 100)
    }


    
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




//MARK: - Current status of habit completion
enum HabitStatus: String, Codable {
    case inProgress
    case completed
}
