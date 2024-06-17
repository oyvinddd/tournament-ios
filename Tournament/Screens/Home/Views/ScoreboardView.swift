//
//  ScoreboardView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 01/06/2024.
//

import SwiftUI

struct ScoreboardView: View {
    
    @Binding var selectedPlayer: Player?
    @Binding var showMatchRegistration: Bool
    
    var scoreboard: [Player]
    
    init(_ scoreboard: [Player], _ selectedPlayer: Binding<Player?>, _ showMatchRegistration: Binding<Bool>) {
        self.scoreboard = scoreboard
        self._selectedPlayer = selectedPlayer
        self._showMatchRegistration = showMatchRegistration
    }
    
    var body: some View {
        
        VStack {
            
            List {
                
                Section {
                    
                    ForEach(scoreboard.indices, id: \.self) { index in
                        let player = scoreboard[index]
                        
                        PlayerView(index+1, player, index == scoreboard.count - 1)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .padding(.horizontal, 16)
                            .padding(.top, index == 0 ? 16 : 0)
                            .background(.white)
                            .onTapGesture {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                selectedPlayer = player
                            }
                    }
                    
                } header: {
                    
                    VStack {
                        HStack {
                            
                            Text("Scoreboard")
                                .font(Font.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.Text.normal)
                                .padding(.leading, 16)
                                .padding(.vertical, 8)
                            
                            Spacer()
                            
                            Text("Matches")
                                .font(Font.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.Text.subtitle)
                                .padding(.vertical, 8)
                            
                            Text("Wins")
                                .frame(width: 50, alignment: .trailing)
                                .font(Font.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.Text.subtitle)
                                .padding(.trailing, 16)
                                .padding(.vertical, 8)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.vertical, 0)
                        .listSectionSeparator(.visible)
                        .listRowInsets(EdgeInsets())
                        
                        Divider()
                            .frame(maxWidth: .infinity)
                    }
                }
                .listSectionSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .background(.white)
            }
            .listStyle(.plain)
            .listRowSpacing(20)
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListHeaderHeight, 0)
            .scrollDismissesKeyboard(.immediately)
        }
        
        // bottom bar
        ZStack {
            
            Button(action: matchRegistrationTapped) {
                Image(systemName: "plus")
                    .font(Font.system(size: 16, weight: .bold))
                    .frame(width: 100)
            }
            .buttonStyle(MainButtonStyle())
        }
        .frame(maxWidth: .infinity)
        .safeAreaPadding(.bottom)
        .padding(.bottom, 16)
    }
    
    private func matchRegistrationTapped() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        showMatchRegistration.toggle()
    }
}

// MARK: - Player view

private struct PlayerView: View {
    
    let placement: Int
    let player: Player
    let isLast: Bool
    
    private var stringFromPlacement: String {
        guard !isLast else {
            return "💩"
        }
        
        switch placement {
        case 1: return "🥇"
        case 2: return "🥈"
        case 3: return "🥉"
        default: return "\(placement)"
        }
    }
    
    private var matchesPlayed: String {
        player.matchesPlayed == 0 ? "-" : "\(player.matchesPlayed)"
    }
    
    private var matchesWon: String {
        player.matchesPlayed == 0 ? "-" : "\(player.matchesWon)"
    }
    
    init(_ placement: Int, _ player: Player, _ isLast: Bool) {
        self.placement = placement
        self.player = player
        self.isLast = isLast
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
                
                Text("\(player.score) points")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.Text.subtitle)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            Text("\(matchesPlayed)")
                .font(Font.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.Text.normal)
            
            Text("\(matchesWon)")
                .frame(width: 50, alignment: .trailing)
                .font(Font.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.Text.normal)
        }
    }
}
