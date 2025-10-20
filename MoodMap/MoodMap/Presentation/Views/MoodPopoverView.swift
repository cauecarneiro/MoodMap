//
//  MoodPopoverView.swift
//  MoodMap
//
//  Created by Rodrigo Barbosa Pereira on 20/10/25.
//

import SwiftUI

struct MoodPopoverView: View {
    @Binding var isPresented: Bool
    @Binding var textReview: String
        
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Como está o local?")
                    .foregroundStyle(.gray)
                    .bold()
                MoodButtonsView()
                
                    .padding()
                
                Text("Conte mais (opcional)")
                    .foregroundStyle(.gray)
                    .bold()
                TextEditor(text: $textReview)
                    .textInputAutocapitalization(.never)
                    .textEditorStyle(.automatic)
                
                Button("Enviar") {
                    // Lógica de enviar a avaliação
                    isPresented = false
                }
                .font(.headline)
                .buttonStyle(.bordered)
                .frame(alignment: .center)
            }
            .navigationTitle("Avaliar aqui")
        }
    }
}

#Preview {
    MoodPopoverView(isPresented: .constant(true), textReview: .constant(""))
}

struct MoodButtonsView: View {
    var body: some View {
        VStack(spacing: 12) {
            Button("Chato") {
                print("chato")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            
            Button("Legal") {
                print("Legal")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            
            Button("Animado") {
                print("Animado")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            
            Button("Tranquilo") {
                print("Tranquilo")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            
            Button("Perigoso") {
                print("Perigoso")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}
