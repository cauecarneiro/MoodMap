//
//  MoodButtonsView.swift
//  MoodMap
//
//  Created by Rodrigo Barbosa Pereira on 20/10/25.
//

import SwiftUI

struct MoodButtonsView: View {
    @Binding var selectedMood: String

    private let moods = ["Chato", "Legal", "Animado", "Tranquilo", "Perigoso"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(moods, id: \.self) { mood in
                Button(mood) {
                    selectedMood = mood
                }
                .font(.headline)
                .buttonStyle(.bordered)
                .tint(mood == selectedMood ? .blue : nil)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .cornerRadius(32)
    }
}
