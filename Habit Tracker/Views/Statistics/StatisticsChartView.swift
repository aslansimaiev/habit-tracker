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
        RuleMark(x: .value("Day", stat.day.chartIndex))
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
    let data: [WeekStat]
    @State private var selectedDay: WeekStat?
    var body: some View {
        
        Chart(data) {

            LineMark(
                x: .value("Day", $0.day.chartIndex),
                y: .value("Tasks", $0.value)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(.green)

            AreaMark(
                x: .value("Day", $0.day.chartIndex),
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

            if let selectedDay, selectedDay.day == $0.day {
                SelectedDayRuleMark(stat: $0)
            }
        }
        .frame(height: 200)
        .chartXScale(domain: -0.5...6.5)
        .chartXAxis {
            AxisMarks(values: Array(0...6)) { value in
                AxisGridLine()
                AxisValueLabel {
                    if let index = value.as(Int.self),
                       let day = Weekday.allCases.first(where: { $0.chartIndex == index }) {
                        Text(day.short)
                            .offset(x: -15)
                    }
                }
            }
        }
        .onAppear {
            guard selectedDay == nil else { return }
            let today = Weekday.today
            selectedDay = data.first(where: { $0.day == today })
        }
    }
}

#Preview {
    let mock = WeekStat.mockWeek
    StatisticsChartView(data: mock)
}
