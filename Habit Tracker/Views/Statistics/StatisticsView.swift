//
//  StatisticsView.swift
//  Habit Tracker
//
//  Created by NIL on 06.01.2026.
//

import SwiftUI
import SwiftData
struct StatisticsView: View {
    
    @Query var habits: [Habit]
    @Query var tasks: [TaskInstance]
    
    var completedHabits: [Habit] {
        habits.filter {
            $0.progressValue == 1.0
        }
    }
    let weekDays: [Weekday] = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    var weekStats: [WeekStat] {
        habits.weekStats(for: weekDays)
    }
    var completedTasks: [TaskInstance] {
        tasks.filter {
            $0.status == .completed
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    //MARK: - Total Stastistics
                    HStack {
                        VStack(spacing: 7){
                            Text("Tasks Completed")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text("\(completedTasks.count) ")
                                .font(.system(size: 24, weight: .medium))
                        }
                        .frame(minWidth: 170, minHeight: 95)
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 10))
                        Spacer()
                        VStack(spacing: 7){
                            Text("Habits Built")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("\(completedHabits.count) ")
                                .font(.system(size: 24, weight: .medium))
                        }
                        .frame(minWidth: 170, minHeight: 95)
                        .clipShape(.rect(cornerRadius: 10))
                        .background(.white)
                    }
                    //MARK: - My Habit Records
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
                    
                    
                    //MARK: - Statistics ChartView
                    
                    HStack{
                        Text("This Week’s Statistics")
                            .padding(.vertical)
                            .fontWeight(.medium)
                        Spacer()
                        Text("Weekly")
                            .font(.caption)
                        
                    }
                    .padding(.bottom, 50)
                    StatisticsChartView(data: weekStats)
                    Spacer()
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("My Statistics")
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
    {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(
            for: Habit.self,
            HabitSubtaskTemplate.self,
            TaskInstance.self,
            configurations: config
        )
        let context = container.mainContext
        
        // Habit 1
        let morningHabit = Habit.mock()
        context.insert(morningHabit)
        
        // Habit 2
        let eveningHabit = Habit.mock()
        eveningHabit.title = "Evening Wind Down"
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
        
        return StatisticsView()
            .modelContainer(container)
    }()
}
