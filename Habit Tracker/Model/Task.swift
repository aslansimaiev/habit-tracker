//
//  Ефіл.swift
//  Habit Tracker
//
//  Created by NIL on 04.01.2026.
//

import Foundation

struct Task: Identifiable, Codable, Hashable {
    let id: UUID
    let templateId: UUID
    var status: TaskStatus
}

enum TaskStatus: String, Codable {
    case pending
    case inProgress
    case completed
}
