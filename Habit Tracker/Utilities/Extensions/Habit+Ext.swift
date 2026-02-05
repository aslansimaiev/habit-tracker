//
//  Habit+Ext.swift
//  Habit Tracker
//
//  Created by NIL on 02.02.2026.
//
import Foundation
extension Habit {
    var completedTasksCount: Int {
        taskInstances.filter { $0.status == .completed }.count
    }
    
    var habitDaysLeft: Int {
        totalSessions - completedTasksCount
    }
    
    var progressPercentage: Int {
        return Int(progressValue * 100)
    }
    
    func hasTask(for date: Date, template: HabitSubtaskTemplate) -> Bool {
        taskInstances.contains {
            $0.date == date && $0.template == template
        }
    }
}
