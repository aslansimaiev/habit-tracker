//
//  Habit+Ext.swift
//  Habit Tracker
//
//  Created by NIL on 02.02.2026.
//

extension Habit {
    var completedTasksCount: Int {
        taskInstances.filter { $0.status == .completed }.count
    }
    
    var habitDaysLeft: Int {
        totalSessions - completedTasksCount
    }
}
