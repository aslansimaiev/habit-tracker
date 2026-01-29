//
//  Habit_TrackerApp.swift
//  Habit Tracker
//
//  Created by NIL on 30.12.2025.
//

import SwiftUI
import SwiftData

@main
struct Habit_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.colorScheme, .light) 
                .modelContainer(for: [Habit.self, HabitDay.self, HabitPreset.self, HabitSubtaskTemplate.self, Task.self, WeekStat.self])
        }
    }
}
