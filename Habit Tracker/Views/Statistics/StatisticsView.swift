//
//  StatisticsView.swift
//  Habit Tracker
//
//  Created by NIL on 06.01.2026.
//

import SwiftUI
import SwiftData

struct StatisticsView: View {

    @Query private var habits: [Habit]
    @Query private var tasks: [TaskInstance]

    private var completedTasks: [TaskInstance] {
        tasks.filter { $0.status == .completed }
    }

    private var completedHabits: [Habit] {
        habits.filter { $0.totalSessions > 0 && $0.completedDaysCount >= $0.totalSessions }
    }

    private var weekStats: [WeekStat] {
        habits.weekStats(for: Weekday.allCases)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {

                    // MARK: - Total Statistics
                    HStack {
                        statCard(
                            title: "Tasks Completed",
                            value: "\(completedTasks.count)"
                        )

                        Spacer()

                        statCard(
                            title: "Habits Built",
                            value: "\(completedHabits.count)"
                        )
                    }

                    // MARK: - My Habit Records
                    Text("My Habit Records")
                        .padding(.vertical)
                        .fontWeight(.medium)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(habits) { habit in
                                HabitRecordCard(habit: habit)
                            }
                        }
                    }

                    // MARK: - Statistics ChartView
                    HStack {
                        Text("This Week’s Statistics")
                            .padding(.vertical)
                            .fontWeight(.medium)

                        Spacer()

                        Text("Weekly")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.bottom, 12)

                    StatisticsChartView(data: weekStats)

                    Spacer(minLength: 24)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .background(Color.htBackground)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My Statistics")
                        .font(.callout)
                        .fontWeight(.semibold)
                }
            }
        }
    }

    private func statCard(title: String, value: String) -> some View {
        VStack(spacing: 7) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.system(size: 24, weight: .medium))
        }
        .frame(minWidth: 170, minHeight: 95)
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    StatisticsView()
        .withPreviewContainer()
}
