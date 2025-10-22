//
//  MoodButtonsView.swift
//  MoodMap
//
//  Created by Rodrigo Barbosa Pereira on 20/10/25.
//

import SwiftUI

struct MoodButtonsView: View {
    @Binding var selectedMoods: Set<String>

    private let moods = ["Chato", "Legal", "Animado", "Tranquilo", "Perigoso"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(moods, id: \.self) { mood in
                Button(mood) {
                    if selectedMoods.contains(mood) {
                        selectedMoods.remove(mood)
                    } else {
                        selectedMoods.insert(mood)
                    }
                }
                .font(.headline)
                .buttonStyle(.bordered)
                .tint(selectedMoods.contains(mood) ? .blue : nil)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .cornerRadius(32)
    }
}

#Preview {
    MoodButtonsView(selectedMoods: .constant([]))
}
