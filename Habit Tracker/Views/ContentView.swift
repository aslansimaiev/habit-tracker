//
//  ContentView.swift
//  Habit Tracker
//
//  Created by NIL on 30.12.2025.
//

import SwiftUI
struct CustomTabs: View {
    @Binding var index: Int
    var body: some View {
        HStack {
            Button {
                self.index = 0
            } label: {
                Image( systemName: "house")
                    .font(.system(size: 22))

            }
            .foregroundStyle(self.index == 0 ? .htMain : .secondary)
            
            Spacer(minLength: 0)
            Button {
                self.index = 1

            } label: {
                Image( systemName: "chart.bar")
                    .font(.system(size: 22))

            }
            .foregroundStyle(self.index == 1 ? .htMain : .secondary)

            Spacer(minLength: 0)
            Button {
                
            } label: {
                Image("addHabit").renderingMode(.original)
            }
            .offset(y: -25)
            Spacer(minLength: 0)

            Button {
                self.index = 2

            } label: {
                Image( systemName: "timer")
                    .font(.system(size: 22))

            }
            .foregroundStyle(self.index == 2 ? .htMain : .secondary)

            Spacer(minLength: 0)

            Button {
                self.index = 3

            } label: {
                Image( systemName: "person.crop.circle")
                    .font(.system(size: 22))

            }
            .foregroundStyle(self.index == 3 ? .htMain : .secondary)

        }
        .padding(.horizontal)
    }
}

struct ContentView: View {
    @State var index = 0
    
    var body: some View {
        HomeView(habit: .mock)
            
        Spacer()
        
        CustomTabs(index: self.$index)
    }
}

#Preview {
    ContentView()
}
