//
//  SoundPlayer.swift
//  Habit Tracker
//
//  Created by NIL on 10.02.2026.
//

import AVFoundation

enum SoundPlayer {
    private static var player: AVAudioPlayer?

    static func playComplete() {
        guard let url = Bundle.main.url(forResource: "complete", withExtension: "mp3") else {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Sound error:", error)
        }
    }
}
