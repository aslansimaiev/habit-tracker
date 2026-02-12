//
//  View+Ext.swift
//  Habit Tracker
//
//  Created by NIL on 05.02.2026.
//

import Foundation
import SwiftUI
extension View {
    func cardStyle(color: Color) -> some View {
        self
            .frame(maxWidth: 185, minHeight: 100, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(color)
            )
            .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
    }
}
