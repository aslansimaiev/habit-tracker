//
//  CapsuleButton.swift
//  Habit Tracker
//
//  Created by NIL on 10.02.2026.
//

import SwiftUI

struct CapsuleButton: View {
    enum Style { case filled, outlined }

    let title: String
    let style: Style
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(background)
                .foregroundStyle(foreground)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(border, lineWidth: style == .outlined ? 1 : 0)
                )
        }
    }

    private var background: some ShapeStyle {
        switch style {
        case .filled: return Color.htMain
        case .outlined: return Color.clear
        }
    }

    private var foreground: some ShapeStyle {
        switch style {
        case .filled: return Color.white
        case .outlined: return Color.htMain
        }
    }

    private var border: Color {
        Color.htMain.opacity(0.6)
    }
}

#Preview {
    CapsuleButton(title: "Pause", style: .filled) {
        print("asdaosdas")
    }
}
