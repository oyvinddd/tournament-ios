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
                    PlayerView(placement: index+1, player: scoreboard[index])
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .padding(.horizontal, 16)
                        .background(.white)
                        .onTapGesture {
                            selectedPlayer = scoreboard[index]
                        }
                }
                
            } header: {
                
                HStack {
                    
                    Text("Scoreboard".uppercased())
                        .font(Font.system(size: 14, weight: .heavy))
                        .foregroundStyle(Color.Text.normal)
                        .padding(.top, 16)
                    
                    Spacer()
                    
                    Text("Matches")
                        .font(Font.system(size: 14, weight: .heavy))
                        .foregroundStyle(Color.Text.subtitle)
                    
                    Text("Wins")
                        .font(Font.system(size: 14, weight: .heavy))
                        .foregroundStyle(Color.Text.subtitle)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
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
    
    var body: some View {
        
        HStack {
            
            Text(stringFromPlacement)
                .font(Font.system(size: 17, weight: .heavy))
                .foregroundStyle(Color.Text.subtitle)
                .padding(.trailing, 8)
            
            ZStack {
                Text("🤩")
                    .font(Font.system(size: 24))
                    .padding(.all, 6)
            }
            .background(RoundedRectangle(cornerRadius: 8).fill(.gray))
            .padding(.trailing, 8)
            
            VStack {
                
                Text(player.username.lowercased())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(size: 19, weight: .bold))
                    .padding(.bottom, 1)
                    .foregroundStyle(Color.Text.normal)
                
                Text("\(player.score)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(size: 15, weight: .bold))
                    .foregroundStyle(Color.Text.subtitle)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            Text("\(player.matchesPlayed)")
                .font(Font.system(size: 17, weight: .bold))
                .foregroundStyle(Color.Text.normal)
            
            Text("\(player.matchesWon)")
                .font(Font.system(size: 17, weight: .bold))
                .foregroundStyle(Color.Text.normal)
                .padding(.leading, 32)
        }
    }
}
