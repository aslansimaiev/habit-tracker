//
//  Ефіл.swift
//  Habit Tracker
//
//  Created by NIL on 04.01.2026.
//

import Foundation
import SwiftData
@Model
class Task: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .cascade) var template: HabitSubtaskTemplate
    var status: TaskStatus
    init(id: UUID, template: HabitSubtaskTemplate, status: TaskStatus) {
        self.id = id
        self.template = template
        self.status = status
    }
}

enum TaskStatus: String, Codable {
    case pending
    case inProgress
    case completed
}
