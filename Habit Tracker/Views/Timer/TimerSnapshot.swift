//
//  TimerSnapshot.swift
//  Habit Tracker
//
//  Created by NIL on 10.02.2026.
//

import Foundation
struct TimerSnapshot: Equatable {
    let elapsedSeconds: Double
    let remainingSeconds: Double
    let progress: Double

    let remainingSecondsRounded: Int

    init(task: TaskInstance, now: Date) {
        let running = task.startedAt.map { now.timeIntervalSince($0) } ?? 0
        let elapsed = task.accumulatedSeconds + max(0, running)
        self.elapsedSeconds = elapsed

        let target = task.targetSeconds ?? 0
        let remaining = max(0, target - elapsed)
        self.remainingSeconds = remaining

        if target > 0 {
            self.progress = min(1, elapsed / target)
        } else {
            self.progress = 0
        }

        self.remainingSecondsRounded = Int(remaining.rounded(.down))
    }
}
