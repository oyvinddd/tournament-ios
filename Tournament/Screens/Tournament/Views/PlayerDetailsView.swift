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
                Text(viewModel.player.emoji)
                    .font(Font.system(size: 48))
                    .padding(.all, 6)
            }
            .background(RoundedRectangle(cornerRadius: 8).fill(.gray))
            .padding(.trailing, 8)
            
            Text(viewModel.player.username.lowercased())
                .font(Font.system(size: 20, weight: .bold))
                .foregroundStyle(Color.Text.normal)
                .frame(maxWidth: .infinity)
                .padding(.top, 4)
            
            Button("Register win", action: registerWinTapped)
                .buttonStyle(SecondaryButtonStyle())
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .onAppear {
            viewModel.startScanningForPlayer()
        }
    }
    
    private func registerWinTapped() {
    }
}

#Preview {
    PlayerDetailsView(
        PlayerDetailsViewModel(
            Player(id: UUID(),
                   tournamentId: UUID(),
                   accountId: UUID(),
                   username: "oyvind_h",
                   score: 1200,
                   matchesWon: 6,
                   matchesPlayed: 12
                  )
        )
    )
}
