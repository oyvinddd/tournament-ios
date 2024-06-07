//
//  PlayerDetailsView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 07/06/2024.
//

import SwiftUI

struct PlayerDetailsView: View {
    
    @ObservedObject var viewModel: PlayerDetailsViewModel
    
    init(_ viewModel: PlayerDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        VStack {
         
            ZStack {
                Text("🤩")
                    .font(Font.system(size: 48))
                    .padding(.all, 6)
            }
            .background(RoundedRectangle(cornerRadius: 8).fill(.gray))
            .padding(.trailing, 8)
            
            Text(viewModel.player.username.lowercased())
                .font(Font.system(size: 20, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding(.top, 4)
            
            Button("Register win", action: registerWinTapped)
                .buttonStyle(SecondaryButtonStyle())
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
    
    private func registerWinTapped() {
        
    }
}

#Preview {
    PlayerDetailsView(
        PlayerDetailsViewModel(
            Player(id: UUID(), username: "oyvind_h", score: 1200, matchesPlayed: 12, matchesWon: 6)
        )
    )
}
