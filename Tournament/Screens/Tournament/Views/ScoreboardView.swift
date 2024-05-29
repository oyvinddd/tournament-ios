//
//  ScoreboardView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 05/05/2024.
//

import SwiftUI

struct ScoreboardView: View {
    
    var scoreboard: [Player] = [
        Player(id: UUID(), username: "oyvinddd", score: 1800, matchesPlayed: 8, matchesWon: 2),
        Player(id: UUID(), username: "oyvinddd", score: 1800, matchesPlayed: 8, matchesWon: 2)
    ]
    
    var body: some View {
        
        ZStack {
            
            AccountView(account: Account(id: UUID(), email: "foo", username: "bar", created: Date.now), buttonAction: {})
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
