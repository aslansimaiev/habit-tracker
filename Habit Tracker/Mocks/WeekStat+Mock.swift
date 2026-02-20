//
//  WeekStat+Mock.swift
//  Habit Tracker
//
//  Created by NIL on 05.02.2026.
//

import Foundation
extension WeekStat {
    static let mockWeek: [WeekStat] = [
            WeekStat(day: .monday, value: 3),
            WeekStat(day: .tuesday, value: 5),
            WeekStat(day: .wednesday, value: 2),
            WeekStat(day: .thursday, value: 4),
            WeekStat(day: .friday, value: 6),
            WeekStat(day: .saturday, value: 1),
            WeekStat(day: .sunday, value: 0)
        ]
}
