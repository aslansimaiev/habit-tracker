//
//  HabitSubtaskTemplate+Mock.swift
//  Habit Tracker
//
//  Created by NIL on 10.01.2026.
//

import Foundation
extension HabitSubtaskTemplate {
    
    static func mock(title: String, duration: TimeInterval?, habit: Habit) -> HabitSubtaskTemplate {
        HabitSubtaskTemplate(
            title: title,
            duration: duration,
            habit: habit
        )
    }
}
