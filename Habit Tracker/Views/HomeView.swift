//
//  HomeView.swift
//  Habit Tracker
//
//  Created by NIL on 01.01.2026.
//

import SwiftUI


struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Welcome")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)
                    //MARK: - Current habit card
                    Text("Here will be current habit card")
                    
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
    HomeView()
}
