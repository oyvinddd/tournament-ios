//
//  ScoreboardView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 05/05/2024.
//

import SwiftUI

struct ScoreboardView: View {
    
    var scoreboard: [Player] = [
        Player(id: UUID(), username: "oyvinddd", score: 1800, matchesPlayed: 8, lastSeen: Date.now),
        Player(id: UUID(), username: "rub1", score: 1900, matchesPlayed: 10, lastSeen: Date.now),
        Player(id: UUID(), username: "panzertax", score: 1200, matchesPlayed: 2, lastSeen: Date.now),
        Player(id: UUID(), username: "konstant", score: 200, matchesPlayed: 2, lastSeen: Date.now),
        Player(id: UUID(), username: "fredrik", score: 1200, matchesPlayed: 2, lastSeen: Date.now)
    ]
    
    var body: some View {
        
        ZStack {
            
            AccountView(account: Account(id: UUID(), username: "oyvind_h", created: Date.now), buttonAction: {})
                .frame(maxHeight: .infinity)
                .padding(.top, 0)
            
            List {
                
                // table view header
                
                Section {
                }
                
                // scoreboard
                
                Section {
                    
                    ForEach(scoreboard.indices, id: \.self) { index in
                        
                        let isLast = index == scoreboard.count - 1
                        
                        PlayerView(scoreboard[index], placement: index, isLast: isLast)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .padding(.horizontal, 16)
                    }
                }
            }
            .contentMargins(.bottom, 56, for: .scrollContent)
            .contentMargins(.top, 200, for: .scrollContent)
            .listStyle(.plain)
            .listSectionSpacing(0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ScoreboardView()
}
