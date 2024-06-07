//
//  ScoreboardView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 01/06/2024.
//

import SwiftUI

struct ScoreboardView: View {
    
    @Binding var selectedPlayer: Player?
    
    var scoreboard: [Player]
    
    init(_ scoreboard: [Player], _ selectedPlayer: Binding<Player?>) {
        self.scoreboard = scoreboard
        self._selectedPlayer = selectedPlayer
    }
    
    var body: some View {
        
        List {
            
            Section {
                
                ForEach(scoreboard.indices, id: \.self) { index in
                    let player = scoreboard[index]
                    
                    PlayerView(index+1, player)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .padding(.horizontal, 16)
                        .background(.white)
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            selectedPlayer = player
                        }
                }
                
            } header: {
                
                HStack {
                    
                    Text("Scoreboard")
                        .font(Font.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.Text.normal)
                        .padding(.leading, 16)
                        .background(.green)
                    
                    Spacer()
                    
                    Text("Matches")
                        .font(Font.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.Text.subtitle)
                    
                    Text("Wins")
                        .frame(width: 50, alignment: .trailing)
                        .font(Font.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.Text.subtitle)
                        .padding(.trailing, 16)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .frame(height: 50)
                .background(.red)
                .padding(.bottom, 16)
                .padding(.top, 0)
                .listSectionSeparator(.visible)
            }
            .listSectionSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .background(.white)
        }
        .listStyle(.plain)
        .listRowSpacing(20)
        .scrollDismissesKeyboard(.immediately)
    }
}

// MARK: - Player view

private struct PlayerView: View {
    
    let placement: Int
    let player: Player
    
    private var stringFromPlacement: String {
        switch placement {
        case 1: "🥇"
        case 2: "🥈"
        case 3: "🥉"
        default: "\(placement)"
        }
    }
    
    init(_ placement: Int, _ player: Player) {
        self.placement = placement
        self.player = player
    }
    
    var body: some View {
        
        HStack {
            
            Text(stringFromPlacement)
                .frame(width: 20, alignment: .center)
                .multilineTextAlignment(.center)
                .font(Font.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.Text.subtitle)
                .padding(.trailing, 8)
            
            ZStack {
                Text(player.emoji)
                    .font(Font.system(size: 24))
                    .padding(.all, 6)
            }
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.General.playerBackground))
            .padding(.trailing, 8)
            
            VStack {
                
                Text(player.username.lowercased())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.Text.normal)
                
                Text("\(player.score)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.Text.subtitle)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            Text("\(player.matchesPlayed)")
                .font(Font.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.Text.normal)
            
            Text("\(player.matchesWon)")
                .frame(width: 50, alignment: .trailing)
                .font(Font.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.Text.normal)
        }
    }
}
