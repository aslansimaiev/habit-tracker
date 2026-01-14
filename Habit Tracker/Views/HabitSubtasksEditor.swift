//
//  HabitSubtasksEditor.swift
//  Habit Tracker
//
//  Created by NIL on 09.01.2026.
//
import SwiftUI

struct HabitSubtasksEditor: View {
    @Binding var subtasks: [HabitSubtaskTemplate]
    @FocusState private var focusedSubtaskId: UUID?

    var body: some View {
        List {
            ForEach($subtasks) { $subtask in
                subtaskRow($subtask)
            }
            .onDelete { indexSet in
                subtasks.remove(atOffsets: indexSet)
            }

            addButton
        }
        .navigationTitle("Subtasks")
    }

    private func subtaskRow(
        _ subtask: Binding<HabitSubtaskTemplate>
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {

            TextField("Subtask title", text: subtask.title)
                .font(.headline)
                .textFieldStyle(.plain)
                .focused($focusedSubtaskId, equals: subtask.id)

            // DURATION
            HStack {
                if let duration = subtask.duration.wrappedValue {
                    TextField(
                        "Minutes",
                        value: Binding(
                            get: { Int(duration / 60) },
                            set: { subtask.duration.wrappedValue = TimeInterval($0 * 60) }
                        ),
                        format: .number
                    )
                    .keyboardType(.numberPad)

                    Text("min")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else {
                    Text("No timer")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Button("Add timer") {
                        subtask.duration.wrappedValue = 300
                    }
                    .font(.caption)
                }
            }
        }
        .padding(.vertical, 6)
    }

    private var addButton: some View {
        Button {
            let newSubtask = HabitSubtaskTemplate(
                id: UUID(),
                title: "",
                duration: nil
            )

            subtasks.append(newSubtask)

            focusedSubtaskId = newSubtask.id
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
