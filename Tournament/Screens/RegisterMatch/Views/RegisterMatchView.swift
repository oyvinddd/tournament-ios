//
//  RegisterMatchView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import SwiftUI

struct RegisterMatchView: View {
    
    @ObservedObject var viewModel = RegisterMatchViewModel()
    
    var body: some View {
        ZStack {
            
            DiscoveredPlayerView(Player(
                id: UUID(),
                username: "oyvinddd",
                score: 1200,
                matchesPlayed: 12,
                lastSeen: Date.now))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
    }
}
