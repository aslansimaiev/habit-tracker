//
//  HabitRecordCard.swift
//  Habit Tracker
//
//  Created by NIL on 05.02.2026.
//

import SwiftUI
struct HabitRecordCard: View {
    let habit: Habit

    private var isCompleted: Bool {
        habit.totalSessions > 0 && habit.completedDaysCount >= habit.totalSessions
    }

    var body: some View {
        if isCompleted {
            completedCard
        } else {
            inProgressCard
        }
    }
}

extension HabitRecordCard {

    private var completedCard: some View {
        VStack(alignment: .leading) {
            Text("100%")
                .font(.title2)
                .fontWeight(.medium)

            Spacer()

            VStack(alignment: .leading) {
                Text(habit.title)
                    .font(.system(size: 12, weight: .semibold))

                Text("100% Complete")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
        }
        .cardStyle(color: .htStatisticsCompleted)
    }

    private var inProgressCard: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(habit.progressPercentage)%")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)

                Spacer()

                Text("In Progress")
                    .padding(8)
                    .font(.caption)
                    .background(.white)
                    .foregroundStyle(.htMain)
                    .clipShape(.capsule)
            }

            Spacer()

            VStack(alignment: .leading) {
                Text(habit.title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white)

                Text("\(habit.completedDaysCount)/\(habit.totalSessions) days")
                    .foregroundStyle(.white)
                    .font(.caption)
            }
        }
        .cardStyle(color: .htMain)
    }
}

#Preview {
    let mock = Habit.mock()
    HabitRecordCard(habit: mock)
}
