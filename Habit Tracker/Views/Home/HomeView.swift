//
//  HomeView.swift
//  Habit Tracker
//
//  Created by NIL on 01.01.2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(
        filter: #Predicate {$0.progressValue != 1.0},
        sort: [SortDescriptor(\Habit.progressValue, order: .reverse)],
    )
    var habits: [Habit]
    
    var habit: Habit? {
        return habits.first
    }
    

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
    {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(
            for: Habit.self,
            HabitSubtaskTemplate.self,
            TaskInstance.self,
            WeekStat.self,
            configurations: config
        )
        let context = container.mainContext

        let morningHabit = Habit.mock()
        context.insert(morningHabit)

        let eveningHabit = Habit.mock()
        eveningHabit.title = "Evening Wind Down"
        eveningHabit.completedCount = 2
        context.insert(eveningHabit)

        let subtask = HabitSubtaskTemplate(
            title: "Read book",
            duration: 600,
            habit: eveningHabit
        )
        context.insert(subtask)
        eveningHabit.subtasks.append(subtask)

        return HomeView()
            .modelContainer(container)
    }()
}
