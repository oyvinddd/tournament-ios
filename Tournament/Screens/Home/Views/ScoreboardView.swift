//
//  ScoreboardView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 01/06/2024.
//

import SwiftUI

struct ScoreboardView: View {
    
    var scoreboard: [Player]
    
    init(_ scoreboard: [Player]) {
        self.scoreboard = scoreboard
    }
    
    var body: some View {
        
        List {
            
            Section {
                
                ForEach(scoreboard.indices, id: \.self) { index in
                    PlayerView(index: index, player: scoreboard[index])
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .padding(.horizontal, 16)
                        .background(.white)
                }
                
            } header: {
                
                HStack {
                    
                    Text("Scoreboard".uppercased())
                        .font(Font.system(size: 14, weight: .heavy))
                        .foregroundStyle(Color.Text.normal)
                    
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
                .padding(.vertical, 8)
                
            }
            .listSectionSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .background(.white)
        }
        .listStyle(.plain)
        .listRowSpacing(20)
    }
}

private struct PlayerView: View {
    
    let index: Int
    let player: Player
    
    var body: some View {
        
        HStack {
            
            Text("\(index + 1)")
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
