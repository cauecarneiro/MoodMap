//
//  MoodTextEditorView.swift
//  MoodMap
//
//  Created by Rodrigo Barbosa Pereira on 20/10/25.
//

import SwiftUI

struct MoodTextEditorView: View {
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    
    private let characterLimit = 140
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextEditor(text: $text)
                .textInputAutocapitalization(.sentences)
                .focused($isFocused)
                .frame(maxWidth: .infinity)
                .scrollContentBackground(.hidden)
                .padding()
                .scrollDismissesKeyboard(.immediately)
                .onChange(of: text) { _, newValue in
                    if newValue.count > characterLimit {
                        text = String(newValue.prefix(characterLimit))
                    }
                }
            
            Divider()
                .padding(.horizontal, 16)
                .padding(.top, 12)
            
            HStack {
                Spacer()
                Text("\(text.count)/\(characterLimit)")
                    .foregroundStyle(.secondary)
                    .font(.headline)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}
