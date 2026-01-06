//
//  TaskRow.swift
//  Habit Tracker
//
//  Created by NIL on 06.01.2026.
//

import SwiftUI

struct TaskRow: View {
    let task: Task

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
        VStack(alignment: .leading) {
            Text(task.title)

            if let time = task.time {
                Text("at \(time, format: .dateTime.hour().minute())")
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
                
            } label:  {
                Text("Start")
                    .padding(EdgeInsets(top: 7, leading: 25, bottom: 7, trailing: 25))
                
                    .background(.htMain)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
            // TODO: - Change inProgress
        case .completed, .inProgress:
            Image("completedTask")
        }
    
    }

    private var backgroundColor: Color {
        task.status == .completed ? Color("htCompletedColor") : .white
    }
}

#Preview {
    TaskRow(task: .mock)
}
