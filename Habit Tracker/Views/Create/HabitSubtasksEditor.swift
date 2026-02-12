//
//  HabitSubtasksEditor.swift
//  Habit Tracker
//
//  Created by NIL on 09.01.2026.
//
import SwiftUI
import SwiftData

struct HabitSubtasksEditor: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Bindable var habit: Habit
    @FocusState private var focus: Field?
    @State private var showSubtaskValidationError = false
    @State private var validationMessage = ""
    
    private var hasInvalidSubtasks: Bool {
        habit.subtasks.contains { $0.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
    
    private var hasNoSubtasks: Bool {
        habit.subtasks.isEmpty
    }
    
    private enum Field: Hashable {
        case title(UUID)
        case minutes(UUID)
    }
    let onFinish: () -> Void
    
    var body: some View {
        List {
            ForEach($habit.subtasks) { $subtask in
                subtaskRow($subtask)
            }
            .onDelete { indexSet in
                habit.subtasks.remove(atOffsets: indexSet)
            }
            
            addButton
        }
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("Subtasks")
        
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") { focus = nil }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") { saveHabit() }
            }
        }
        .alert("Can't save", isPresented: $showSubtaskValidationError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(validationMessage)
        }
    }
    
    //MARK: - A row in the list of subtasks
    private func subtaskRow(_ subtask: Binding<HabitSubtaskTemplate>) -> some View {
        
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                // TITLE
                TextField("Subtask title", text: subtask.title)
                    .font(.headline)
                    .textFieldStyle(.plain)
                    .focused($focus, equals: .title(subtask.id.wrappedValue))
                    .padding(.vertical, 8)
                
                Spacer()
                
                if let duration = subtask.duration.wrappedValue {
                    HStack(spacing: 4) {
                        TextField(
                            "",
                            value: Binding(
                                get: { Int(duration / 60) },
                                set: { subtask.duration.wrappedValue = TimeInterval($0 * 60) }
                            ),
                            format: .number
                        )
                        .focused($focus, equals: .minutes(subtask.id.wrappedValue))
                        .frame(width: 50)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                        
                        Text("min")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                } else {
                    Button {
                        subtask.duration.wrappedValue = 300
                        focus = .minutes(subtask.id.wrappedValue)
                    } label: {
                        Text("Add timer")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(6)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)
            
            // Divider
            Divider()
                .padding(.leading)
        }
        .padding(.vertical, 2)
    }
    
    //MARK: - When user want to add another subtask for Habit
    private var addButton: some View {
        Button {
            let newSubtask = HabitSubtaskTemplate(
                title: "",
                duration: nil
            )
            
            habit.subtasks.append(newSubtask)
            
            focus = .title(newSubtask.id)
        } label: {
            Label("Add subtask", systemImage: "plus")
        }
    }
    
    //MARK: - When new habit is submitted. Need to create Habit, and tasks
    func saveHabit() {
        if hasNoSubtasks {
            validationMessage = "Add at least one subtask."
            showSubtaskValidationError = true
            return
        }

        if hasInvalidSubtasks {
            validationMessage = "Subtask title can't be empty. Fill it in or delete the subtask."
            showSubtaskValidationError = true

            // (опционально) автофокус на первый пустой
            if let first = habit.subtasks.first(where: {
                $0.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }) {
                focus = .title(first.id)
            }
            return
        }

        context.insert(habit)
        TaskGenerationService.generateTodayTasksIfNeeded(habits: [habit], context: context)
        do {
            try context.save()
            onFinish()
        } catch {
            print("Failed to save habit:", error)
        }
    }
}

#Preview {
    NavigationStack {
        HabitSubtasksEditor(habit: Habit.mock(), onFinish: {})
    }
    .withPreviewContainer()
}
