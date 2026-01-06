//
//  HabitPresetCard.swift
//  Habit Tracker
//
//  Created by NIL on 05.01.2026.
//

import SwiftUI

struct HabitPresetCard: View {
    let preset: HabitPreset
    var body: some View {
        VStack{
            Image(preset.imageName)
                .resizable()
                .frame(width: 130, height: 115)
            Text(preset.habit.title)
                .padding(.bottom)
        }
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))

    }
}

#Preview {
    HabitPresetCard(preset: .cardio)
}
