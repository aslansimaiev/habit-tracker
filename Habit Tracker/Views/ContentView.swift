//
//  ContentView.swift
//  Habit Tracker
//
//  Created by NIL on 30.12.2025.
//

import SwiftUI

struct ContentView: View {
    @State var index = 0
    
    var body: some View {
        if index == 0 {
            HomeView()
        }
        else if index == 1 {
//            StatisticsView()
        }
        Spacer()
        
        CustomTabs(index: self.$index)
    }
}

#Preview {
    ContentView()
}
