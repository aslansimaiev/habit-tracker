//
//  TaskTimerView.swift
//  Habit Tracker
//
//  Created by NIL on 09.02.2026.
//


import SwiftUI
import SwiftData


struct TaskTimerView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var showCancelAlert = false

    @Bindable var task: TaskInstance

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { timeline in
            let now = timeline.date
            let elapsed = elapsedSeconds(now: now)
            let remaining = remainingSeconds(elapsed: elapsed)
            let progress = progressValue(elapsed: elapsed)

            VStack(spacing: 16) {

                if task.status == .completed {
                    completedContent
                } else if task.hasTimer {
                    timerContent(progress: progress, remaining: remaining)
                } else {
                    noTimerContent
                }

                Spacer()

                controls(remaining: remaining)

                Spacer(minLength: 8)
            }
            .padding()
            .onChange(of: remaining) { _, newValue in
                guard task.status == .inProgress, task.hasTimer else { return }
                if newValue <= 0 {
                    task.complete()
                    SoundPlayer.playComplete()
                    try? context.save()
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


    // MARK: - Content blocks

    private func timerContent(progress: Double, remaining: Double) -> some View {
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

    private var noTimerContent: some View {
        VStack(spacing: 18) {
            // “презентабельный” блок вместо кольца
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

    private var completedContent: some View {
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

            Button {
                dismiss()
            } label: {
                Text("Back to Home")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.htMain)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }

            taskInfo
        }
        .padding(.top, 8)
    }

    private var taskInfo: some View {
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

    // MARK: - Controls

    @ViewBuilder
    private func controls(remaining: Double) -> some View {
        switch task.status {
        case .pending:
            if task.hasTimer {
                primaryButton("Start") {
                    task.start()
                    try? context.save()
                }
            } else {

                primaryButton("Complete") {
                    task.complete()
                    SoundPlayer.playComplete()
                    try? context.save()
                }
            }

        case .inProgress:
            HStack(spacing: 12) {
                primaryButton("Pause") {
                    task.pause()
                    try? context.save()
                }
                secondaryButton("Complete") {
                    task.complete()
                    SoundPlayer.playComplete()
                    try? context.save()
                }
            }

        case .paused:
            HStack(spacing: 12) {
                secondaryButton("Cancel") {
                    showCancelAlert = true
                }
                primaryButton("Continue") {
                    task.start()
                    try? context.save()
                }
            }

        case .completed:
            // Кнопка уже в completedContent
            EmptyView()
        }
    }

    // MARK: - Time math

    private func elapsedSeconds(now: Date) -> Double {
        let running = task.startedAt.map { now.timeIntervalSince($0) } ?? 0
        return task.accumulatedSeconds + max(0, running)
    }

    private func remainingSeconds(elapsed: Double) -> Double {
        guard let target = task.targetSeconds else { return 0 }
        return max(0, target - elapsed)
    }

    private func progressValue(elapsed: Double) -> Double {
        guard let target = task.targetSeconds, target > 0 else { return 0 }
        return min(1, elapsed / target)
    }

    private var minutesText: String? {
        guard let target = task.targetSeconds, target > 0 else { return nil }
        return "\(Int(target / 60)) minutes"
    }

    private func timeString(_ seconds: Double) -> String {
        let total = max(0, Int(seconds.rounded(.down)))
        let h = total / 3600
        let m = (total % 3600) / 60
        let s = total % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }

    // MARK: - Buttons

    private func primaryButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.htMain)
                .foregroundStyle(.white)
                .clipShape(Capsule())
        }
    }

    private func secondaryButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(.clear)
                .foregroundStyle(Color.htMain)
                .overlay(
                    Capsule()
                        .stroke(Color.htMain.opacity(0.6), lineWidth: 1)
                )
        }
    }
}

#Preview {
    let habit = Habit.mock()
    habit.subtasks.append(HabitSubtaskTemplate(title: "Bobob", duration: nil))
    let task = TaskInstance(date: .now, habit: habit, template: habit.subtasks[0])
    return TaskTimerView(task: task)
    
}
