//
//  TaskInstance+Ext.swift
//  Habit Tracker
//
//  Created by NIL on 09.02.2026.
//
import Foundation

extension TaskInstance {
    var elapsedSeconds: Double {
        let running = startedAt.map { Date().timeIntervalSince($0) } ?? 0
        return accumulatedSeconds + running
    }
    
    var remainingSeconds: Double {
        guard let targetSeconds else { return 0 }
        return max(0, targetSeconds - elapsedSeconds)
    }
    
    var progress: Double {
        guard let targetSeconds, targetSeconds > 0 else { return 0 }
        return min(1, elapsedSeconds / targetSeconds)
    }
    
    var hasTimer: Bool {
        (targetSeconds ?? 0) > 0
    }
    
    func start() {
        guard status == .pending || status == .paused else { return }
        startedAt = Date()
        status = .inProgress
    }
    
    func pause() {
        guard status == .inProgress, let startedAt else { return }
        accumulatedSeconds += Date().timeIntervalSince(startedAt)
        self.startedAt = nil
        status = .paused
    }
    
    func complete() {
        if let startedAt {
            accumulatedSeconds += Date().timeIntervalSince(startedAt)
            self.startedAt = nil
        }
        status = .completed
    }
    
    func cancelAndReset() {
        startedAt = nil
        accumulatedSeconds = 0
        status = .pending
    }
}
