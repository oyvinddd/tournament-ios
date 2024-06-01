//
//  HomeView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/05/2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = TournamentViewModel()
    @State private var showProfile = false
    
    @State var scoreboard: [Player] = [
        Player(id: UUID(), username: "oyvind_h", score: 1200, matchesPlayed: 9, matchesWon: 2),
        Player(id: UUID(), username: "rub1", score: 1300, matchesPlayed: 9, matchesWon: 7)
    ]
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                // header view
                HStack {
                    Text(viewModel.title)
                        .font(Font.system(size: 26, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    Button(action: profileButtonTapped) {
                        ZStack {
                            
                            Text("😍")
                                .font(Font.system(size: 22))
                                .padding(.all, 6)
                        }
                        
                        .background(RoundedRectangle(cornerRadius: 10).fill(.green))
                    }
                }
                .padding(.horizontal, 16)
                
                // main content goes inside here
                VStack {
                    
                    ScoreboardView(scoreboard: $scoreboard)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .clipShape(
                    .rect(
                        topLeadingRadius: 16,
                        topTrailingRadius: 16
                    )
                )
                //.shadow(color: .green, radius: 4, x: 0, y: 1)
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.General.background)
        .sheet(isPresented: $showProfile) {
            SettingsView().presentationDetents([.large])
        }
        .onAppear {
            viewModel.getTournament()
        }
    }
    
    private func profileButtonTapped() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        showProfile.toggle()
    }
}

#Preview {
    HomeView()
}
