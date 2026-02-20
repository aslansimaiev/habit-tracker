//
//  CurrentHabitCard.swift
//  Habit Tracker
//
//  Created by NIL on 06.01.2026.
//

import SwiftUI

struct CurrentHabitCard: View {
    let habit: Habit
    var body: some View {
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
                HabitProgressBar(
                    progress: habit.progressValue,
                    trackStyle: AnyShapeStyle(.white.opacity(0.25)),
                    progressStyle: AnyShapeStyle(.white)
                )
                .frame(width: 50, height: 50)
                    .onAppear()
                    .padding(.trailing, 10)
                Text("\(String(habit.habitDaysLeft)) days left")
                    .foregroundStyle(.white)
                    .font(.caption)
                
                Spacer()
                NavigationLink {
                    HabitListView()
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
        
    }
}

#Preview {
    CurrentHabitCard(habit: .mock())
}
