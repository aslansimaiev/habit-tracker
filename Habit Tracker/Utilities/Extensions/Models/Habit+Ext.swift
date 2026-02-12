//
//  Habit+Ext.swift
//  Habit Tracker
//
//  Created by NIL on 02.02.2026.
//
import Foundation
extension Habit {    
    
    var habitDaysLeft: Int {
        max(0, totalSessions - completedDaysCount)
    }
    
    
    func hasTask(for date: Date, template: HabitSubtaskTemplate) -> Bool {
        taskInstances.contains {
            Calendar.current.isDate($0.date, inSameDayAs: date) && $0.template == template
        }
    }
}
