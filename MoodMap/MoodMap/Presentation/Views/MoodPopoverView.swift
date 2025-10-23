//
//  MoodPopoverView.swift
//  MoodMap
//
//  Created by Rodrigo Barbosa Pereira on 20/10/25.
//

import SwiftUI
import CoreLocation

struct MoodPopoverView: View {
    @Binding var textReview: String
    @FocusState private var isEditing: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var selectedMood: String = ""
    @State private var nomeDoLocal: String = ""
    @FocusState private var isNomeFocused: Bool
    let location: CLLocationCoordinate2D?
    
    let textEditorCharacterLimit = 140

    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nome do local")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    
                    TextField("Digite aqui...", text: $nomeDoLocal)
                        .focused($isNomeFocused)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.systemGray6))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(isNomeFocused ? Color.blue.opacity(0.6) : Color.clear, lineWidth: 1)
                        )
                        .scrollDismissesKeyboard(.immediately)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Como está o local?")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        
                        MoodButtonsView(selectedMood: $selectedMood)
                        
                        if selectedMood.isEmpty {
                            Text("Selecione pelo menos um humor para enviar.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Conte mais")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        
                        MoodTextEditorView(text: $textReview, isFocused: $isEditing)
                            .simultaneousGesture(TapGesture().onEnded({ isEditing = false }))
                    }
                    .padding()
                    
                    Button("Enviar") {
                        let latitude = location?.latitude ?? -15.214213213
                        let longitude = location?.longitude ?? -70.12321312
                        
                        let coordinates = CLLocation(latitude: latitude, longitude: longitude)
                        
                        let mood = selectedMood
                        let text = textReview.trimmingCharacters(in: .whitespacesAndNewlines)
                        var messageComponents: [String] = []
                       
                        if !text.isEmpty {
                            messageComponents.append("Comentário: \"" + text + "\"")
                        }
                        
                        let message = messageComponents.isEmpty ? "(Nenhuma avaliação fornecida)" : messageComponents.joined(separator: " | ")
                        print("Mensagem escrita: Sentimento - \(mood) - \(message)")
                        
                        isEditing = false
                        dismiss()
                    }
                    .font(.headline)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(32)
                    .disabled(selectedMood.isEmpty)
                    .opacity(selectedMood.isEmpty ? 0.2 : 1)
                }
                .navigationTitle("Avaliar aqui")
            }
        }
    }
}
