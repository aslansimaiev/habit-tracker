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
    
    @Query(sort: [SortDescriptor(\Habit.title, order: .forward)])
    private var habitsRaw: [Habit]
    @Query var tasks: [TaskInstance]
    
    @State private var selectedPreset: HabitPreset?
    
    private var habits: [Habit] {
        habitsRaw
            .filter { $0.completedTasksCount < $0.totalSessions }
            .sorted { $0.progressValue > $1.progressValue }
    }
    var todayTasks: [TaskInstance] {
        tasks.filter {
            Calendar.current.isDateInToday($0.date)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    header
                    if !habits.isEmpty{
                        GeometryReader { geo in
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(habits) {h in
                                        CurrentHabitCard(habit: h)
                                            .frame(width: geo.size.width * 0.88)
                                        
                                    }
                                }
                            }
                        }
                        .frame(height: 200)
                        todayList
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
            .sheet(item: $selectedPreset) { preset in
                CreateHabitView(draft: preset.makeDraftHabit()) {
                    selectedPreset = nil
                }
            }
            .onAppear {
                TaskGenerationService.generateTodayTasksIfNeeded(
                    habits: habitsRaw,
                    context: context
                )
            }
        }
    }
    
    private var todayList: some View {
        VStack {
            HStack {
                Text("Today's List")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            
            VStack(spacing: 8) {
                ForEach(todayTasks) { task in
                    TaskRow(task: task)
                }
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
            }

            ScrollView(.horizontal) {
                HStack {
                    ForEach(HabitPreset.mockList) { preset in
                        HabitPresetCard(preset: preset) {
                            selectedPreset = preset

                        }
                    }
                }
            }
        }
    }
}
#Preview {
    HomeView()
        .withPreviewContainer()
}
