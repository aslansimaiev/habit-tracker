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
    //temp
    var inProgressHabit: Habit {
        return habits[0]
    }
    var completedHabit: Habit {
        return habits[1]
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
                    Text("My Habit Records")
                        .padding(.vertical)
                        .fontWeight(.medium)
                    
                    HStack {
                        //COMPLETED Template
                        VStack (alignment: .leading ){
                            
                            HStack{
                                Text("\(inProgressHabit.progressPercentage)%")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                                Spacer()
                                Text("In Progress")
                                    .padding(8)
                                    .font(.caption)
                                    .background(.white)
                                    .foregroundStyle(.htMain)
                                    .clipShape(.capsule)
                                
                            }
                            Spacer()
                            VStack(alignment: .leading){
                                Text(inProgressHabit.title)
                                    .font(.system(size: 12, weight: .semibold))

                                    .foregroundStyle(.white)
                                
                                Text("\(inProgressHabit.completedCount)/\(inProgressHabit.totalSessions) days")
                                    .foregroundStyle(.white)
                                    .font(.caption)
                                
                            }
                            
                            
                            
                        }
                        .frame(maxWidth: 185, alignment: .leading)                        .frame( height: 100)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color(.htMain))
                        )
                        .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
                        
                        //COMPLETED Template
                        VStack (alignment: .leading ){
                            
                            Text("100%")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                            
                            VStack(alignment: .leading){
                                Text(completedHabit.title)
                                    .font(.system(size: 12, weight: .semibold))
                                                                
                                Text("100% Complete")
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                                
                            }
                            
                            
                            
                        }
                        .frame( height: 100)
                        .frame(maxWidth: 185, alignment: .leading)                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color(.htStatisticsCompleted))
                        )
                        .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
                        
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
                    StatisticsChartView()
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
