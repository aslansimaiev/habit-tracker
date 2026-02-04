//
//  HomeView.swift
//  Habit Tracker
//
//  Created by NIL on 01.01.2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context

    @Query(
        filter: #Predicate {$0.progressValue != 1.0},
        sort: [SortDescriptor(\Habit.progressValue, order: .reverse)],
    )
    var habits: [Habit]
    
    @Query var tasks: [TaskInstance]
    var todayTasks: [TaskInstance] {
        tasks.filter {
            Calendar.current.isDateInToday($0.date)
        }
    }
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
                        todayList
                        //Text(todayTasks[0].template.title)
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
                generateTasksIfNeeded()
            }
//            .onChange(of: habits) { _, newHabits in
//                generateTasksIfNeeded(habits: newHabits)
//            }
        }
    }
    
    //MARK: - On appear will generate tasks for today if they are not existing and save it in SwiftData
    private func generateTasksIfNeeded() {
        guard !habits.isEmpty else { return }
        
        guard let todayWeekday = Weekday(
            rawValue: Calendar.current.component(.weekday, from: Date())
        ) else { return }
        
        let today = Calendar.current.startOfDay(for: Date())
        
        let todayHabits = habits.filter {
            $0.daysOfWeek.contains(todayWeekday)
        }
        
        for habit in todayHabits {
            for subtask in habit.subtasks {
                
                if !habit.hasTask(for: today, template: subtask) {
                    context.insert(TaskInstance(date: today, habit: habit, template: subtask))
                }
                
            }
        }
    }
    
    
    private var todayList: some View {
        VStack {
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

            VStack(spacing: 8) {
                ForEach(todayTasks) { task in
                    TaskRow(task: task)
                }
//                ForEach(habits.taskInstances) { task in
//                    if let template = habit.subtasks.first(where: {
//                        $0.id == task.templateId
//                    }) {
//                        TaskRow(task: task, template: template)
//                    }
//                }
            }
        }
    }
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

        // Habit 1
        let morningHabit = Habit.mock()
        context.insert(morningHabit)

        // Habit 2
        let eveningHabit = Habit.mock()
        eveningHabit.title = "Evening Wind Down"
        eveningHabit.completedCount = 2
        context.insert(eveningHabit)

        // Subtask
        let subtask = HabitSubtaskTemplate(
            title: "Read book",
            duration: 600,
            habit: eveningHabit
        )
        eveningHabit.subtasks.append(subtask)
        context.insert(subtask)
        
        // Task
        let task = TaskInstance(
            date: Date(),
            habit: eveningHabit,
            template: subtask
        )
        task.status = .completed

        eveningHabit.taskInstances.append(task)

        context.insert(task)

        return HomeView()
            .modelContainer(container)
    }()
}
