//
//  ContentView.swift
//  Habit Tracker
//
//  Created by NIL on 30.12.2025.
//

import SwiftUI
struct ContentView: View {
    @State private var index: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            Group {
                if index == 0 {
                    HomeView()
                } else if index == 1 {
                    StatisticsView()
                } else {
                    HomeView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            CustomTabs(index: $index)
        }
        .background(Color.htBackground)
    }
}

#Preview {
    ContentView()
        .withPreviewContainer()
}
