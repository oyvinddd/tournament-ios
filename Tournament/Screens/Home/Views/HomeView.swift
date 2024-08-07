//
//  HomeView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/05/2024.
//

import SwiftUI

private enum MissingTournamentState {
    case search, register
}

struct HomeView: View {
    
    @ObservedObject var viewModel = TournamentViewModel()
    @State private var playerFilter = ""
    @State private var showProfile = false
    @State private var showMatchRegistration = false
    @State private var missingState: MissingTournamentState = .search
    @State private var selectedPlayer: Player?
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                // top header
                HeaderView(
                    account: $viewModel.account,
                    title: $viewModel.title,
                    playerFilter: $playerFilter,
                    btBroadcastingState: $viewModel.btBroadcastingState,
                    showAccount: $showProfile
                )
                
                // main content goes inside here
                VStack {
                    
                    switch viewModel.state {
                    case .idle:
                        Spacer()
                        Text("Idle!")
                        Spacer()
                    case .loading:
                        LoadingView("Please wait...", "Loading tournament data!")
                    case .success(let tournament):
                        ScoreboardView(tournament.scoreboard, $selectedPlayer, $showMatchRegistration)
                            .refreshable { reloadTournament() }
                    case .missingTournament:
                        TournamentSearchView()
                    case .failure(let error):
                        ErrorView(error, action: reloadTournament)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .clipShape(.rect(topLeadingRadius: 16, topTrailingRadius: 16))
                .shadow(color: Color.Text.normal.opacity(0.6), radius: 10, x: 0, y: 2)
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.General.background)
        .sheet(isPresented: $showProfile) {
            AccountView(showProfile: $showProfile)
                .presentationDetents([.large])
        }
        .sheet(item: $selectedPlayer) { player in
            PlayerDetailsView(PlayerDetailsViewModel(player))
                .presentationDetents([.medium])
        }
        .onAppear {
            reloadTournament()
            //viewModel.startBluetoothBroadcasting()
        }
        .onDisappear {
            //viewModel.stopBluetoothBroadcasting()
        }
    }
    
    private func profileButtonTapped() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        showProfile.toggle()
    }
    
    private func reloadTournament() {
        viewModel.getTournament()
    }
}

#Preview {
    HomeView()
}
