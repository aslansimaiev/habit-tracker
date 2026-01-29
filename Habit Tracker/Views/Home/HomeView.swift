//
//  HomeView.swift
//  Habit Tracker
//
//  Created by NIL on 01.01.2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(sort: \Habit.title) var habits: [Habit] = []
    var habit: Habit? {
        return habits.first
    }

    /// Temporary daily tasks (until SwiftData)
    @State private var tasks: [Task] = []

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    header
                    if let habit = habit {
                        CurrentHabitCard(habit: habit)
//                        todayList
                    
                    } else {
                        ContentUnavailableView(label: {
                            Label("No Habit currently developed", systemImage: "list.bullet.rectangle.portrait")
                        }, description: {
                            Text("Start adding habits to your profile.")
                            Text("You can select one of the habits from the preset. or create your own")
                        }, actions: {
                            
                        })
                    }
                    

                    habitPresets
                    Spacer()
                }
                .padding(.horizontal)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Home")
                            .font(.callout)
                            .fontWeight(.semibold)
                    }
                }
            }
            .background(Color.htBackground)
            .onAppear {
//                generateTasksIfNeeded()
            }
        }
    }
    
//    private func generateTasksIfNeeded() {
//        guard tasks.isEmpty else { return }
//
//        tasks = habit.subtasks.map { template in
//            Task(
//                id: UUID(),
//                templateId: template.id,
//                status: .pending
//            )
//        }
//    }
//    private var todayList: some View {
//        VStack {
//            HStack {
//                Text("Today's List")
//                    .font(.callout)
//                    .fontWeight(.medium)
//
//                Spacer()
//
//                NavigationLink("See All", destination: ContentView())
//                    .font(.caption)
//                    .foregroundStyle(.primary)
//            }
//            .padding(.vertical)
//
//            VStack(spacing: 8) {
//                ForEach(tasks) { task in
//                    if let template = habit.subtasks.first(where: {
//                        $0.id == task.templateId
//                    }) {
//                        TaskRow(task: task, template: template)
//                    }
//                }
//            }
//        }
//    }
    private var header: some View {
        Text("Welcome")
            .font(.title2)
            .fontWeight(.medium)
            .foregroundStyle(.primary)
            .padding(.bottom)
    }
    private var habitPresets: some View {
        VStack {
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
        }
    }
}

#Preview {
    
    HomeView()
}
