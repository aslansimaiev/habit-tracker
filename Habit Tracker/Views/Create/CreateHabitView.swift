//
//  CreateHabitView.swift
//  Habit Tracker
//
//  Created by NIL on 08.01.2026.
//

import SwiftUI

struct CreateHabitView: View {
    @State private var title: String = ""
    @State private var subTitle: String = ""
    
    @State private var totalSessions = 15
    @State private var selectedDays: Set<Weekday> = []
    @State private var subtasks: [HabitSubtaskTemplate] = []
    
    var body: some View {
        VStack{
            Text("Create new habit")
                .font(.callout)
                .fontWeight(.semibold)
            VStack(alignment: .leading) {
                
                Text("Set a Goal")
                TextField("Eg. Make Mediation Daily Habit!", text: $title)
                    .background(.white)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.bottom)
                Text("Set a subtitle (optional)")
                    .font(.system(size: 14))
                TextField("To feel better", text: $subTitle)
                    .background(.white)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
                
                HStack {
                    Text("Total sessions")
                    Stepper(value: $totalSessions, in: 3...100) {
                        Text("\(totalSessions) days")
                            .fontWeight(.medium)
                    }
                }
                .padding(.vertical)
                
                //MARK: - Select Days
                HStack {
                    Text("Set Reminder")
                        .font(.headline)
                    
                    Spacer()
                    
                    Button("Clear") {
                        selectedDays.removeAll()
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
                .padding(.vertical)
                HStack (alignment: .center){
                    ForEach(Weekday.allCases, id: \.self) { day in
                        Button {
                            toggle(day)
                        } label: {
                            Text(day.shortLetter)
                                .font(.callout)
                                .fontWeight(.medium)
                                .frame(width: 40, height: 40)
                                .background(
                                    Circle()
                                        .fill(
                                            selectedDays.contains(day)
                                            ? Color.htMain.opacity(0.6)
                                            : Color.white.opacity(0.6)
                                        )
                                )
                                .foregroundStyle(
                                    selectedDays.contains(day)
                                    ? .white
                                    : .secondary
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
                Section {
                    NavigationLink {
                        HabitSubtasksEditor(subtasks: $subtasks)
                    } label: {
                        HStack {
                            Text("Subtasks")
                            Spacer()
                            Text("\(subtasks.count)")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical)
                    .foregroundStyle(.primary)
                }
            }
            .padding()
        }
        .frame(maxHeight: .infinity)
        .background(.htBackground)
    }
    
    private func toggle(_ day: Weekday) {
        if selectedDays.contains(day) {
            selectedDays.remove(day)
        } else {
            selectedDays.insert(day)
        }
    }
}


#Preview {
    CreateHabitView()
}
