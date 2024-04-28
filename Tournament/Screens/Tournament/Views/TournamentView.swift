//
//  ScoreboardView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct TournamentView: View {
    
    @ObservedObject var viewModel = TournamentViewModel()
    @State var showSettingsDialog = false
    @State var showInviteDialog = false
    
    var body: some View {
        
        VStack {
            
            if let account = viewModel.account {
                AccountView(account: account, buttonAction: settingsButtonTapped)
            }
            
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
                    .padding(.bottom, -8) // what?
                
                // scoreboard
                List {
                    
                    ForEach(scoreboard.indices, id: \.self) { index in
                        
                        let isLast = index == scoreboard.count - 1
                        
                        PlayerView(scoreboard[index], placement: index, isLast: isLast)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                    }
                }
                .contentMargins(.bottom, 56, for: .scrollContent)
                .padding(.horizontal, 16)
                .padding(.top, 0)
                .listStyle(.plain)
                .refreshable {
                    viewModel.getTournament()
                }
                
            case .failure(let error):
                
                Spacer()
                
                ErrorView(error)
                    .padding(.horizontal, 16)
                
                Spacer()
            }
        }
        .background(.clear)
        .sheet(isPresented: $showSettingsDialog) {
            SettingsView()
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showInviteDialog) {
            InvitePlayer()
                .presentationDetents([.medium])
        }
        .onAppear {
            viewModel.getTournament()
        }
    }
    
    private func settingsButtonTapped() {
        showSettingsDialog = true
    }
}
