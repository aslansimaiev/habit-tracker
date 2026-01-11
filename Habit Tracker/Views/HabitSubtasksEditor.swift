//
//  HabitSubtasksEditor.swift
//  Habit Tracker
//
//  Created by NIL on 09.01.2026.
//

import SwiftUI

struct HabitSubtasksEditor: View {
    @Binding var subtasks: [HabitSubtaskTemplate]

    var body: some View {
        List {
            ForEach(subtasks) { subtask in
                subtaskRow(subtask)
            }
            .onDelete { indexSet in
                subtasks.remove(atOffsets: indexSet)
            }

            addButton
        }
        .navigationTitle("Subtasks")
    }
    
    private func subtaskRow(_ subtask: HabitSubtaskTemplate) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(subtask.title)
                .font(.headline)

            if let duration = subtask.duration {
                Text("\(Int(duration / 60)) min")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                Text("No timer")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
    
    private var addButton: some View {
        Button {
            subtasks.append(
                HabitSubtaskTemplate(
                    id: UUID(),
                    title: "New subtask",
                    duration: nil
                )
            )
        } label: {
            Label("Add subtask", systemImage: "plus")
        }
    }
}

#Preview {
    HabitSubtasksEditor(
        subtasks: .constant(HabitSubtaskTemplate.mockList)
    )
}
