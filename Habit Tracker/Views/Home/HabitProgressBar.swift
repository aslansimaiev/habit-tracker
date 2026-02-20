//
//  HabitProgressBar.swift
//  Habit Tracker
//
//  Created by NIL on 03.01.2026.
//

import SwiftUI

struct HabitProgressBar: View {
    let progress: Double

    var lineWidth: CGFloat = 6
    var trackOpacity: Double = 0.2

    var trackStyle: AnyShapeStyle = AnyShapeStyle(.secondary.opacity(0.25))

    var progressStyle: AnyShapeStyle = AnyShapeStyle(.tint)

    @State private var animatedProgress: Double = 0.0

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundStyle(trackStyle)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(max(animatedProgress, 0.0), 1.0)))
                .stroke(
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .foregroundStyle(progressStyle)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: animatedProgress)
        }
        .onAppear { animatedProgress = progress }
        .onChange(of: progress) { _, newValue in
            animatedProgress = newValue
        }
        .accessibilityLabel("Progress")
        .accessibilityValue("\(Int(progress * 100)) percent")
    }
}

#Preview {
    
    HabitProgressBar(
        progress: 0.65,
        trackStyle: AnyShapeStyle(.white.opacity(0.25)),
        progressStyle: AnyShapeStyle(.white)
    )
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.htMain))
            )
}
