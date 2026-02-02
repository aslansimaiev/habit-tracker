//
//  HabitProgressBar.swift
//  Habit Tracker
//
//  Created by NIL on 03.01.2026.
//

import SwiftUI

struct HabitProgressBar: View {
    let progress: Double
    @State private var animatedProgress: Double = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6.0)
                .opacity(0.21)
                .foregroundStyle(.white)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(animatedProgress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                .foregroundStyle(.white)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut, value: animatedProgress)
        }
        .onAppear {
            animatedProgress = progress
        }
    }
    
}

#Preview {
    
    HabitProgressBar(progress: 0.65)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.htMain))
            )
}
