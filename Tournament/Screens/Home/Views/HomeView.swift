//
//  HomeView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/05/2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = TournamentViewModel()
    @State private var playerFilter = ""
    @State private var showProfile = false
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                HeaderView(title: $viewModel.title, playerFilter: $playerFilter)
                
                // main content goes inside here
                VStack {
                    
                    switch viewModel.state {
                    case .idle:
                        Text("Idle!")
                    case .loading:
                        Text("Loading!")
                    case .success(let tournament):
                        ScoreboardView(tournament.sortedScoreboard)
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
                .shadow(color: Color.black.opacity(0.6), radius: 10, x: 0, y: 2)
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.General.background)
        .sheet(isPresented: $showProfile) {
            SettingsView().presentationDetents([.large])
        }
        .onAppear { reloadTournament() }
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
