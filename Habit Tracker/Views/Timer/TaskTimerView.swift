//
//  TaskTimerView.swift
//  Habit Tracker
//
//  Created by NIL on 09.02.2026.
//


import SwiftUI
import SwiftData

import SwiftUI
import SwiftData

struct TaskTimerView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var showCancelAlert = false

    @Bindable var task: TaskInstance

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { timeline in
            let snapshot = TimerSnapshot(task: task, now: timeline.date)

            VStack(spacing: 16) {
                content(snapshot: snapshot)
                Spacer()
                controls(snapshot: snapshot)
                Spacer(minLength: 8)
            }
            .padding()
            .onChange(of: snapshot.remainingSecondsRounded) { _, newValue in
                guard task.status == .inProgress, task.hasTimer else { return }
                if newValue <= 0 {
                    completeWithFeedback()
                }
            }
        }
        .alert("Cancel timer?", isPresented: $showCancelAlert) {
            Button("Cancel timer", role: .destructive) {
                task.cancelAndReset()
                try? context.save()
            }
            Button("Keep", role: .cancel) {}
        } message: {
            Text("This will reset elapsed time and return the task to Start.")
        }
    }
}

// MARK: - UI Sections

private extension TaskTimerView {
    @ViewBuilder
    func content(snapshot: TimerSnapshot) -> some View {
        switch task.status {
        case .completed:
            completedContent

        default:
            if task.hasTimer {
                timerContent(progress: snapshot.progress, remaining: snapshot.remainingSeconds)
            } else {
                noTimerContent
            }
        }
    }

    func timerContent(progress: Double, remaining: Double) -> some View {
        VStack(spacing: 18) {
            ZStack {
                TimerRing(progress: progress)
                    .frame(width: 280, height: 280)

                Text(timeString(remaining))
                    .font(.system(size: 44, weight: .semibold, design: .rounded))
                    .monospacedDigit()
            }
            .padding(.top, 8)

            taskInfo
        }
    }

    var noTimerContent: some View {
        VStack(spacing: 18) {
            VStack(spacing: 10) {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 44, weight: .semibold))
                    .foregroundStyle(Color.htMain)

                Text("Ready to do this?")
                    .font(.title2.bold())

                Text("Complete the task when you finish.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 26)
            .padding(.horizontal, 16)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 18))

            taskInfo
        }
        .padding(.top, 8)
    }

    var completedContent: some View {
        VStack(spacing: 18) {
            VStack(spacing: 10) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 52, weight: .semibold))
                    .foregroundStyle(Color.htMain)

                Text("Completed!")
                    .font(.title.bold())

                Text("Nice work. You can go back to Home.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 28)
            .padding(.horizontal, 16)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 18))

            CapsuleButton(
                title: "Back to Home",
                style: .filled
            ) {
                dismiss()
            }

            taskInfo
        }
        .padding(.top, 8)
    }

    var taskInfo: some View {
        VStack(spacing: 8) {
            if let minutesText = minutesText {
                Text(minutesText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text(task.template.title)
                .font(.title3.bold())
                .multilineTextAlignment(.center)

            Text(task.habit.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(3)
        }
        .padding(.top, 4)
    }
}

// MARK: - Controls

private extension TaskTimerView {
    @ViewBuilder
    func controls(snapshot: TimerSnapshot) -> some View {
        switch task.status {
        case .pending:
            if task.hasTimer {
                CapsuleButton(title: "Start", style: .filled) {
                    task.start()
                    try? context.save()
                }
            } else {
                CapsuleButton(title: "Complete", style: .filled) {
                    completeWithFeedback()
                }
            }

        case .inProgress:
            HStack(spacing: 12) {
                CapsuleButton(title: "Pause", style: .filled) {
                    task.pause()
                    try? context.save()
                }
                CapsuleButton(title: "Complete", style: .outlined) {
                    completeWithFeedback()
                }
            }

        case .paused:
            HStack(spacing: 12) {
                CapsuleButton(title: "Cancel", style: .outlined) {
                    showCancelAlert = true
                }
                CapsuleButton(title: "Continue", style: .filled) {
                    task.start()
                    try? context.save()
                }
            }

        case .completed:
            EmptyView()
        }
    }

    func completeWithFeedback() {
        task.complete()
        SoundPlayer.playComplete()
        try? context.save()
    }
}

// MARK: - Formatting

private extension TaskTimerView {
    var minutesText: String? {
        guard let target = task.targetSeconds, target > 0 else { return nil }
        return "\(Int(target / 60)) minutes"
    }

    func timeString(_ seconds: Double) -> String {
        let total = max(0, Int(seconds.rounded(.down)))
        let h = total / 3600
        let m = (total % 3600) / 60
        let s = total % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
}

#Preview {
    let habit = Habit.mock()
    habit.subtasks.append(HabitSubtaskTemplate(title: "Bobob", duration: nil))
    let task = TaskInstance(date: .now, habit: habit, template: habit.subtasks[0])
    return TaskTimerView(task: task)
    
}
