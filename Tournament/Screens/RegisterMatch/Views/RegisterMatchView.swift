//
//  RegisterMatchView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import SwiftUI

struct RegisterMatchView: View {
    
    @ObservedObject var viewModel = RegisterMatchViewModel()
    @State var showConfirmDialog = false
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        ZStack {
            
            DiscoveredPlayerView(Player(
                id: UUID(),
                tournamentId: UUID(), 
                accountId: UUID(),
                username: "oyvinddd",
                score: 1200,
                matchesWon: 2, 
                matchesPlayed: 12)
            )
            .onTapGesture {
                feedbackGenerator.impactOccurred()
                showConfirmDialog.toggle()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.clear)
        .sheet(isPresented: $showConfirmDialog) {
            ConfirmRegisterMatchView()
                .presentationDetents([.medium])
        }
    }
}
