//
//  PreviewSupport.swift
//  Habit Tracker
//
//  Created by NIL on 06.02.2026.
//

import SwiftUI
import SwiftData

enum PreviewSupport {

    static let container: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)

        let container = try! ModelContainer(
            for: Habit.self,
            HabitSubtaskTemplate.self,
            TaskInstance.self,
            configurations: config
        )

        seed(into: container.mainContext)
        return container
    }()

    static func seed(into context: ModelContext) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!

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

        //  Task today (completed)
        let taskToday = TaskInstance(date: today, habit: eveningHabit, template: subtask)
        taskToday.status = .completed
        context.insert(taskToday)

        //  Task yesterday (completed)
        let taskYesterday = TaskInstance(date: yesterday, habit: eveningHabit, template: subtask)
        taskYesterday.status = .completed
        context.insert(taskYesterday)

        try? context.save()
    }
}

extension View {
    func withPreviewContainer() -> some View {
        self.modelContainer(PreviewSupport.container)
    }
}
