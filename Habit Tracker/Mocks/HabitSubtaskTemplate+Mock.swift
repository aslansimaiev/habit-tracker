//
//  HabitSubtaskTemplate+Mock.swift
//  Habit Tracker
//
//  Created by NIL on 10.01.2026.
//

import Foundation
extension HabitSubtaskTemplate {

    static let stretch = HabitSubtaskTemplate(
        id: UUID(),
        title: "Morning stretch",
        duration: 600 // 10 min
    )

    static let water = HabitSubtaskTemplate(
        id: UUID(),
        title: "Drink a glass of water",
        duration: nil
    )

    static let meditation = HabitSubtaskTemplate(
        id: UUID(),
        title: "Meditation",
        duration: 900 // 15 min
    )

    static let mockList: [HabitSubtaskTemplate] = [
        .stretch,
        .water,
        .meditation
    ]
}
