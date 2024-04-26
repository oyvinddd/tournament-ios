//
//  ScoreboardView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct TournamentView: View {
    
    @ObservedObject var viewModel = TournamentViewModel()
    @State var showInviteDialog = false
    
    var body: some View {
        
        VStack {
            
            if let tournament = viewModel.tournament {
                
                // header
                TournamentHeaderView(title: tournament.title)
                
                // scoreboard
                List {
                    
                    ForEach(tournament.scoreboard) { player in
                        PlayerView(player: player)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                    }
                }
                .padding(.horizontal, 16)
                .listStyle(.plain)
            }
        }
        .background(.red)
        //.ignoresSafeArea(.all)
        .sheet(isPresented: $showInviteDialog) {
            InvitePlayer()
                .presentationDetents([.medium])
        }
        .onAppear {
            viewModel.getTournament()
        }
    }
}
