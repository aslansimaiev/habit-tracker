//
//  HabitDetailView.swift
//  Habit Tracker
//
//  Created by NIL on 06.02.2026.
//

import SwiftUI

struct HabitDetailView: View {
    let habit: Habit

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                progressSection
                subtasksSection
            }
            .padding()
        }
        .navigationTitle("Habit")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension HabitDetailView {
    var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(habit.title)
                .font(.largeTitle.bold())

            let subtitle = habit.subtitle.trimmingCharacters(in: .whitespacesAndNewlines)
            if !subtitle.isEmpty {
                Text(subtitle)
                    .foregroundStyle(.secondary)
            }
            Text(habit.daysOfWeek.shortDayList)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
private extension HabitDetailView {
    var progressSection: some View {
        HStack(spacing: 16) {
            HabitProgressBar(
                progress: habit.progressValue,
                trackStyle: AnyShapeStyle(.secondary.opacity(0.25)),
                progressStyle: AnyShapeStyle(.htMain)
            )
            .frame(width: 60, height: 60)

            VStack(alignment: .leading) {
                Text("Progress")
                    .font(.headline)

                Text("\(habit.progressPercentage)% completed")
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }
}

private extension HabitDetailView {
    var subtasksSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Subtasks")
                .font(.headline)

            if habit.subtasks.isEmpty {
                Text("No subtasks yet")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(habit.subtasks) { subtask in
                        SubtaskRow(subtask: subtask)
                    }
                }
            }
        }
    }
}

struct SubtaskRow: View {
    let subtask: HabitSubtaskTemplate

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(subtask.title)
                    .font(.body)

                if let duration = subtask.duration {
                    let minutes = max(1, Int(duration / 60))

                    Text("\(minutes) min")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()


        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    HabitDetailView(habit: .mock())
}
