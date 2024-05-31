//
//  TournamentSearchView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 31/05/2024.
//

import SwiftUI

struct TournamentSearchView: View {
    
    @ObservedObject var viewModel = TournamentSearchViewModel()
    
    var body: some View {
        
        VStack {
            
            // scoreboard
            List {
                /*
                ForEach(scoreboard.indices, id: \.self) { index in
                    PlayerView(index: index)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .padding(.horizontal, 16)
                        .background(.white)
                }
                 */
            }
            .listStyle(.plain)
            .listRowSpacing(20)
            .contentMargins(.top, 16)
        }
    }
}

#Preview {
    TournamentSearchView()
}
