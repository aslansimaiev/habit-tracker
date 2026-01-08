//
//  StatisticsChartView.swift
//  Habit Tracker
//
//  Created by NIL on 07.01.2026.
//

import SwiftUI
import Charts

struct SelectedDayRuleMark: ChartContent {
    let stat: WeekStat

    var body: some ChartContent {
        RuleMark(x: .value("Day", stat.day.short))
            .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color.green.opacity(0.15),
                            Color.green.opacity(0.05)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            .lineStyle(StrokeStyle(lineWidth: 40))
            .annotation(position: .top,
                        spacing: 0,
                        overflowResolution: .init(x: .fit(to: .chart),
                                                  y: .disabled)) {
                annotationView
            }
    }

    var annotationView: some View {
        VStack(alignment: .leading) {
            Text(stat.day.short)
                .font(.caption.bold())
                .foregroundStyle(.secondary)

            Text("\(stat.value) tasks")
                .font(.headline)
                .foregroundStyle(.green)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4)
        )
    }
}


struct StatisticsChartView: View {
    let data: [WeekStat] = [
        .init(day: .monday, value: 1),
        .init(day: .tuesday, value: 2),
        .init(day: .wednesday, value: 2),
        .init(day: .thursday, value: 3),
        .init(day: .friday, value: 4),
        .init(day: .saturday, value: 3),
        .init(day: .sunday, value: 2)
    ]
    var selectedDay: WeekStat {
        return data[1]
    }
    var body: some View {
        Chart(data) {
            
            LineMark(
                x: .value("Day", $0.day.short),
                y: .value("Tasks", $0.value)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(.green)

            AreaMark(
                x: .value("Day", $0.day.short),
                y: .value("Tasks", $0.value)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(
                LinearGradient(
                    colors: [.green.opacity(0.3), .clear],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            if $0.day.short == selectedDay.day.short {
                SelectedDayRuleMark(stat: selectedDay)
            }

        }
        .frame(height: 200)
        
    }
    
}

#Preview {
    StatisticsChartView()
}
