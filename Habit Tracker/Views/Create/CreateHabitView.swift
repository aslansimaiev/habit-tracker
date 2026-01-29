//
//  CreateHabitView.swift
//  Habit Tracker
//
//  Created by NIL on 08.01.2026.
//

import SwiftUI

struct CreateHabitView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    
    @State private var draft = Habit()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Create new habit")
                    .font(.callout)
                    .fontWeight(.semibold)
                VStack(alignment: .leading) {
                    
                    Text("Set a Goal")
                    TextField("Eg. Make Mediation Daily Habit!", text: $draft.title)
                        .background(.white)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.bottom)
                    Text("Set a subtitle (optional)")
                        .font(.system(size: 14))
                    TextField("To feel better", text: $draft.subtitle)
                        .background(.white)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                    
                    HStack {
                        Text("Total sessions")
                        Stepper(value: $draft.totalSessions, in: 3...100) {
                            Text("\(draft.totalSessions) days")
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
                            draft.daysOfWeek.removeAll()
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
                                                draft.daysOfWeek.contains(day)
                                                ? Color.htMain.opacity(0.6)
                                                : Color.white.opacity(0.6)
                                            )
                                    )
                                    .foregroundStyle(
                                        draft.daysOfWeek.contains(day)
                                        ? .white
                                        : .secondary
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    Section {
                        NavigationLink {
                            HabitSubtasksEditor(habit: draft)
                        } label: {
                            Text("Add Subtasks")
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(.htMain)
                                .foregroundStyle(.white)
                                .font(.callout.bold())
                                .clipShape(.capsule)
                        }
                        .padding(.vertical)
                        .foregroundStyle(.primary)
                    }
                }
                .padding()
            }
            .frame(maxHeight: .infinity)
            .background(.htBackground)
            .toolbar(){
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        
    }
    
    private func toggle(_ day: Weekday) {
        if let index = draft.daysOfWeek.firstIndex(of: day) {
            draft.daysOfWeek.remove(at: index)
        } else {
            draft.daysOfWeek.append(day)
        }
    }
}


#Preview {
    CreateHabitView()
}
