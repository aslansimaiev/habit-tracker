//
//  PreviewSupport.swift
//  Habit Tracker
//
//  Created by NIL on 06.02.2026.
//

import SwiftUI
import SwiftData

enum PreviewSupport {
    static func makeContainer() -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)

        let container = try! ModelContainer(
            for: Habit.self,
            HabitSubtaskTemplate.self,
            TaskInstance.self,
            configurations: config
        )

        seed(into: container.mainContext)
        return container
    }

    static func seed(into context: ModelContext) {
        // Habit 1
        let morningHabit = Habit.mock()
        context.insert(morningHabit)

        // Habit 2
        let eveningHabit = Habit.mock()
        eveningHabit.title = "Evening Wind Down"
        context.insert(eveningHabit)

        // Subtask
        let subtask = HabitSubtaskTemplate(
            title: "Read book",
            duration: 600,
            habit: eveningHabit
        )
        eveningHabit.subtasks.append(subtask)
        context.insert(subtask)

        // Task
        let task = TaskInstance(
            date: Date(),
            habit: eveningHabit,
            template: subtask
        )
        task.status = .completed
        eveningHabit.taskInstances.append(task)
        context.insert(task)
    }
}

extension View {
    func withPreviewContainer() -> some View {
        self.modelContainer(PreviewSupport.makeContainer())
    }
}
