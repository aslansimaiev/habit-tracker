//
//  HomeView.swift
//  Habit Tracker
//
//  Created by NIL on 01.01.2026.
//

import SwiftUI



struct HomeView: View {
    let habit: Habit

    var tasks: Set<Task> {
        return habit.subtasks
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Welcome")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)
                        .padding(.bottom)
                    //MARK: - Current habit card
                    CurrentHabitCard(habit: habit)
                    
                    //MARK: - Today's task list
                    HStack {
                        Text("Today's List")
                            .font(.callout)
                            .fontWeight(.medium)
                        Spacer()
                        NavigationLink("See All", destination: ContentView())
                            .font(.caption)
                            .foregroundStyle(.primary)
                    }
                    .padding(.vertical)
                    VStack {
                        // List of tasks
                        ForEach(Array(tasks)) {task in
                            TaskRow(task: task)
                        }
                    }
                    
                    //MARK: - Habit presets list
                    HStack {
                        Text("Habit Presets")
                            .font(.callout)
                            .fontWeight(.medium)
                            .padding(.vertical)
                        Spacer()
                        NavigationLink("See All", destination: ContentView())
                            .font(.caption)
                            .foregroundStyle(.primary)
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(HabitPreset.mockList) { preset in
                                HabitPresetCard(preset: preset)

                            }
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Home")
                            .font(.callout)
                            .fontWeight(.semibold)
                    }
                }
            }
            .background(Color.htBackground)
        }
    }
}

#Preview {
    
    HomeView(habit: .mock)
}
