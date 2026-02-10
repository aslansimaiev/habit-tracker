//
//  TimerRing.swift
//  Habit Tracker
//
//  Created by NIL on 09.02.2026.
//

import SwiftUI

struct TimerRing: View {
    let progress: Double // 0...1
    var lineWidth: CGFloat = 10
    var trackStyle: AnyShapeStyle = AnyShapeStyle(.secondary.opacity(0.2))
    var progressStyle: AnyShapeStyle = AnyShapeStyle(.htMain)

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundStyle(trackStyle)

            Circle()
                .trim(from: 0, to: CGFloat(min(max(progress, 0), 1)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .foregroundStyle(progressStyle)
                .rotationEffect(.degrees(-90))
        }
    }
}

#Preview {
    TimerRing(progress: 0.55)
}
