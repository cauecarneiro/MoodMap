//
//  ContentView.swift
//  MoodMap
//
//  Created by Breno Marques on 13/10/25.
//

import SwiftUI
import CoreLocation

struct MapView: View {
    @State private var moods: [MoodDTO] = []
    
    var body: some View {
        VStack {
            Text("Salvar novo dado:")
            
            List {
                ForEach(moods, id: \.self) { mood in
                    VStack {
                        Text(mood.feeling)
                        Text(mood.description)
                    }
                }
            }
            
            Button {
                Task {
                    let datasource = MoodDataSource()
                    let newMood = MoodDTO(feeling: "Tédio", description: "A poluição tá alta", location: CLLocation(latitude: -23.5489, longitude: -46.6388))
                    
                    await datasource.saveMood(mood: newMood)
                }
            } label: {
                Text("Salvar")
                    .font(.headline)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {
            let dataSource = MoodDataSource()
            
            moods = dataSource.fetchMoods()
        }
    }
}

#Preview {
    MapView()
}
