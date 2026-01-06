//
//  StatisticsView.swift
//  Habit Tracker
//
//  Created by NIL on 06.01.2026.
//

import SwiftUI

struct StatisticsView: View {
    
    let habits = Habit.mockList
    let tasks = Task.mockList
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
                                
                            Text("\(tasks.count) ")
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
                            Text("\(habits.count) ")
                                .font(.system(size: 24, weight: .medium))
                        }
                        .frame(minWidth: 170, minHeight: 95)
                        .clipShape(.rect(cornerRadius: 10))
                        .background(.white)
                    }
                    //MARK: - My Habit Records
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
    StatisticsView()
}
