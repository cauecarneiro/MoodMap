//
//  MockMapPopoverView.swift
//  MoodMap
//
//  Created by Rodrigo Barbosa Pereira on 20/10/25.
//

import SwiftUI

struct MockMapPopoverView: View {
    @State private var isPresentingPopover = false
    @State private var textOpinion: String = ""

    var body: some View {
        Button("Avaliar Local") {
            isPresentingPopover = true
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
        
        .sheet(isPresented: $isPresentingPopover) {
            MoodPopoverView(textReview: $textOpinion)
                .onDisappear {
                    isPresentingPopover = false
                }
        }
    }
}

#Preview {
    MockMapPopoverView()
}
