//
//  CustomTabs.swift
//  Habit Tracker
//
//  Created by NIL on 06.01.2026.
//

import SwiftUI
struct CustomTabs: View {
    @Binding var index: Int
    @State private var showCreateHabit = false

    var body: some View {
        HStack {
            Spacer(minLength: 0)

            tabButton(system: "house", tab: 0)

            Spacer(minLength: 0)

            Button {
                showCreateHabit = true
            } label: {
                Image("addHabit")
                    .renderingMode(.original)
            }
            .offset(y: -25)

            Spacer(minLength: 0)

            tabButton(system: "chart.bar", tab: 1)
            Spacer(minLength: 0)

        }
        .padding(.horizontal)
        .sheet(isPresented: $showCreateHabit) {
                CreateHabitView(onFinish: {
                    showCreateHabit = false
                    index = 0
                })

        }
    }

    // MARK: - Reusable tab button
    private func tabButton(system: String, tab: Int) -> some View {
        Button {
            index = tab
        } label: {
            Image(systemName: system)
                .font(.system(size: 22))
        }
        .foregroundStyle(index == tab ? .htMain : .secondary)
    }
}

#Preview {
    CustomTabs(index: .constant(0))
}
