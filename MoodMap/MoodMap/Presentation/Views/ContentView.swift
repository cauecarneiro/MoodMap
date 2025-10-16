//
//  ContentView.swift
//  MoodMap
//
//  Created by Breno Marques on 13/10/25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Salvar novo dado:")
            
            Button {
                Task {
                    let datasource = MoodDataSource()
                    let newMood = CreateMoodDTO(id: UUID(), feeling: "Chato", description: "Não tem nada pra fazer aqui", location: CLLocation(latitude: -15.7801, longitude: -47.9292))
                    
                    await datasource.saveMood(mood: newMood)
                }
            } label: {
                Text("Salvar")
                    .font(.headline)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
