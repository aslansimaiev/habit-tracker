//
//  Ефіл.swift
//  Habit Tracker
//
//  Created by NIL on 04.01.2026.
//

import Foundation

struct Task: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String

    // Optional scheduled start time
    var time: Date?

    // Optional duration in seconds
    var duration: TimeInterval?

    var status: TaskStatus
}

enum TaskStatus: String, Codable {
    case pending
    case inProgress
    case completed
}
