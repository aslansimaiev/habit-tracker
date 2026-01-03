//
//  HomeView.swift
//  Habit Tracker
//
//  Created by NIL on 01.01.2026.
//

import SwiftUI



struct HomeView: View {
    let habit: Habit
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Welcome")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)
                    //MARK: - Current habit card
                    VStack (alignment: .leading ){
                        Text(habit.title)
                            .foregroundStyle(.white)
                        Text(habit.subtitle)
                            .foregroundStyle(.white)
                            .font(.caption)
                            .padding(.bottom, 30)
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
                    .frame(maxWidth: .infinity, alignment: .leading)
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
                    LazyVStack {
                        // List of tasks
                        Text( "Task 1 ")
                        Text( "Task 2 ")
                        Text( "Task 3 ")
                        
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
                }
                .padding(.horizontal)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .font(.callout)
                        .fontWeight(.semibold)
                }
            }
            .background(Color.background)
            
        }
        
        
    }
}

#Preview {
    HomeView(habit: .mock)
}
