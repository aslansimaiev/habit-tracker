//
//  HabitListView.swift
//  Habit Tracker
//
//  Created by NIL on 06.02.2026.
//

import SwiftUI
import SwiftData

struct HabitListView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Habit.title, order: .forward)
    private var habits: [Habit]

    @State private var habitToDelete: Habit?
    @State private var showDeleteAlert = false

    var body: some View {
        List {
            if habits.isEmpty {
                ContentUnavailableView(
                    "No habits yet",
                    systemImage: "list.bullet.rectangle",
                    description: Text("Create a habit to see it here.")
                )
                .listRowSeparator(.hidden)
            } else {
                ForEach(habits) { habit in
                    NavigationLink {
                        HabitDetailView(habit: habit)
                    } label: {
                        HabitRowView(habit: habit)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            habitToDelete = habit
                            showDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .navigationTitle("Habits")
        .alert("Delete habit?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                if let habitToDelete {
                    modelContext.delete(habitToDelete)
                    try? modelContext.save()
                    self.habitToDelete = nil
                }
            }
            Button("Cancel", role: .cancel) {
                habitToDelete = nil
            }
        } message: {
            Text("This action will remove the habit and all related data (tasks, subtasks).")
        }
    }
}

// MARK: - Row

private struct HabitRowView: View {
    let habit: Habit

    var body: some View {
        HStack(spacing: 12) {
            HabitProgressBar(
                progress: habit.progressValue,
                trackStyle: AnyShapeStyle(.secondary.opacity(0.25)),
                progressStyle: AnyShapeStyle(.htMain)
            )
            .frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: 6) {
                Text(habit.title)
                    .font(.headline)

                Text(habit.daysOfWeek.shortDayList)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                ProgressView(value: habit.progressValue)
                    .tint(.htMain)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 6) {
                Text("\(habit.progressPercentage)%")
                    .font(.subheadline.bold())

                Text("\(habit.habitDaysLeft) days left")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 6)
    }
}




#Preview {
    HabitListView()
        .withPreviewContainer()

}
