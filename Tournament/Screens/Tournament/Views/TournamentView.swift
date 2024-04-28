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
                    .font(Font.system(size: 32, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .center)
                
            case .success(let tournament):
                
                let scoreboard = tournament.scoreboard.sorted(by: { $0.score > $1.score })
                
                // header
                TournamentHeaderView(title: tournament.title)
                    .padding(.horizontal, 16)
                
                // scoreboard
                List {
                    
                    ForEach(scoreboard.indices, id: \.self) { index in
                        
                        let isFirst = index == 0
                        let isLast = index == scoreboard.count - 1
                        
                        PlayerView(scoreboard[index], placement: index, isFirst: isFirst, isLast: isLast)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                    }
                }
                .padding(.horizontal, 16)
                
                .listStyle(.plain)
                .refreshable {
                    viewModel.getTournament()
                }
                
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
