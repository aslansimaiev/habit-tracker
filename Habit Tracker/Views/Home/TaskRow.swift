//
//  TaskRow.swift
//  Habit Tracker
//
//  Created by NIL on 06.01.2026.
//

import SwiftUI

struct TaskRow: View {
    let task: Task
    let template: HabitSubtaskTemplate

    var body: some View {
        HStack {
            taskInfo

            Spacer()

            trailingContent
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(backgroundColor)
        .clipShape(.rect(cornerRadius: 10))
    }

    private var taskInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(template.title)
                .font(.headline)

            if let duration = template.duration {
                Text("\(Int(duration / 60)) min")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    @ViewBuilder
    private var trailingContent: some View {
        switch task.status {
        case .pending:
            Button {
                // start timer / set inProgress
            } label: {
                Text("Start")
                    .padding(.horizontal, 25)
                    .padding(.vertical, 7)
                    .background(.htMain)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }

        case .inProgress:
            ProgressView()
                .progressViewStyle(.circular)

        case .completed:
            Image("completedTask")
        }
    }

    private var backgroundColor: Color {
        task.status == .completed
            ? Color("htCompletedColor")
            : .white
    }
}

#Preview {
    TaskRow(task: .pending, template: .stretch)
}
