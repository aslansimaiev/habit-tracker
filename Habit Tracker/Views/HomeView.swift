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
                    VStack (alignment: .leading ){
                        Text(habit.title)
                            .foregroundStyle(.white)
                        Text(habit.subtitle)
                            .foregroundStyle(.white)
                            .font(.caption)
                            
                        Text(habit.daysOfWeek.shortDayList)
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(.bottom, 25)
                            
                        HStack {
                            HabitProgressBar(progress: habit.progress)
                                .frame(width: 50, height: 50)
                                .onAppear()
                                .padding(.trailing, 10)
                            Text("\(String(habit.habitDaysLeft)) days left")
                                .foregroundStyle(.white)
                                .font(.caption)
                            
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("See more")
                                    .padding()
                                    .background(.white)
                                    .foregroundStyle(.htMain)
                                    .clipShape(.capsule)
                                    .font(.caption)
                            }
                            
                        }
                    }
                    
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(.htMain))
                    )
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
                    
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
                            if task.status == .pending {
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(task.title)
                                        
                                        if let time = task.time {
                                            Text("at \(time,  format: .dateTime.hour().minute())")
                                                .foregroundStyle(.secondary)
                                                .font(.caption)
                                        }
                                        
                                    }
                                    Spacer()
                                    Button {
                                        
                                    } label:  {
                                        Text("Start")
                                            .padding(EdgeInsets(top: 7, leading: 25, bottom: 7, trailing: 25))
                                        
                                            .background(.htMain)
                                            .foregroundStyle(.white)
                                            .clipShape(Capsule())
                                    }
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 70)
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 10))
                            }
                            else if task.status == .completed {
                                HStack{
                                    
                                    VStack(alignment: .leading){
                                        Text(task.title)
                                        
                                        if let time = task.time {
                                            Text("at \(time,  format: .dateTime.hour().minute())")
                                                .foregroundStyle(.secondary)
                                                .font(.caption)
                                        }
                                        
                                    }
                                    Spacer()
                                    Image("completedTask")
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 70)
                                .background(Color("htCompletedColor"))
                                .clipShape(.rect(cornerRadius: 10))
                            }
                            
                        }
                        
                    }
                    
                    //MARK: - Habit presets list
                    HStack {
                        Text("Habit Presets")
                            .font(.callout)
                            .fontWeight(.medium)
                        Spacer()
                        NavigationLink("See All", destination: ContentView())
                            .font(.caption)
                            .foregroundStyle(.primary)
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(1...100, id: \.self) { i in
                                Text("Habit")
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
