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
            
            switch viewModel.state {
            case .loading:
                
                Text("Loading...")
                    .font(Font.system(size: 82, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .center)
                
            case .success(let tournament):
                
                // header
                TournamentHeaderView(title: tournament.title)
                    .padding(.horizontal, 16)
                
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
                
            case .failure(let error):
                ErrorView(error)
            }
        }
        .background(.clear)
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
