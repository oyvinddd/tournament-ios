//
//  TournamentViewV2.swift
//  Tournament
//
//  Created by Øyvind Hauge on 03/05/2024.
//

import SwiftUI

struct TournamentViewV2: View {
    
    @State private var showMatchRegistration = false
    @State private var showSettings = false
    
    var scoreboard: [Player] = [
        Player(id: UUID(), username: "oyvinddd", score: 1800, matchesPlayed: 8, lastSeen: Date.now),
        Player(id: UUID(), username: "rub1", score: 1900, matchesPlayed: 10, lastSeen: Date.now),
        Player(id: UUID(), username: "panzertax", score: 1200, matchesPlayed: 2, lastSeen: Date.now),
        Player(id: UUID(), username: "konstant", score: 200, matchesPlayed: 2, lastSeen: Date.now),
        Player(id: UUID(), username: "fredrik", score: 1200, matchesPlayed: 2, lastSeen: Date.now)
    ]
    
    private let topContentMargin: CGFloat = 150
    private let cornerRadius: CGFloat = 12
    
    var body: some View {
        
        ZStack {
            
            MatchRegistrationBottomView($showMatchRegistration)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .safeAreaPadding(.bottom, 16)
            
            if !showMatchRegistration {
             
                ZStack {
                    
                    VStack {
                        
                        // empty view
                        ZStack {
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: topContentMargin)
                        .contentMargins(.top, 0)
                        .background(.clear)
                        
                        // clipped view
                        ZStack {
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .background(.white)
                        .clipShape(Circle().trim(from: 0.5, to: 1.0))
                        
                        Spacer()
                            .frame(maxWidth: .infinity)
                            .background(Color.General.defaultBackground)
                    }
                    .frame(maxWidth: .infinity)
                    
                    List {
                        
                        // table view header
                        
                        Section {
                            
                            PlayerInfoView()
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .padding(.horizontal, 16)
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
                    .contentMargins(.top, topContentMargin, for: .scrollContent)
                    .listStyle(.plain)
                    .listSectionSpacing(0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    VStack {
                        Spacer()
                        TournamentBottomView($showMatchRegistration)
                            .background(.white)
                            .shadow(color: Color.gray, radius: 6)
                            .safeAreaPadding(.bottom, 16)
                        //.clipShape(.rect(topLeadingRadius: 20, topTrailingRadius: 20))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .transition(.move(edge: showMatchRegistration ? .top : .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [Color.General.mainBackground2, Color.General.mainBackground1],
                startPoint: .bottomLeading,
                endPoint: .topTrailing
            )
        )
    }
}

// MARK: - Player view

private struct PlayerHeaderView: View {
    
    var body: some View {
        ZStack {
        }
    }
}

// MARK: - Info view

private struct PlayerInfoView: View {
    
    var body: some View {
        
        ZStack {
            
            HStack {
                
                Text("POINTS")
                
                //Spacer()
                //Text("POSITION")
                
            }
            .frame(maxWidth: .infinity)
            .background(.green)
            .padding(.horizontal, 16)
            .padding(.top, 0)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(.white)
        .clipShape(.rect(topLeadingRadius: 12, topTrailingRadius: 12))
    }
}

// MARK: - Button view

private struct TournamentBottomView: View {
    
    @Binding var showMatchRegistration: Bool
    
    init(_ showMatchRegistration: Binding<Bool>) {
        self._showMatchRegistration = showMatchRegistration
    }
    
    var body: some View {
        
        HStack {
            
            Button(action: matchRegistrationTapped) {
                Text("Register Match")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(MainButtonStyle())
            
            Button(action: {}, label: {
                Text(Image(systemName: "gearshape"))
            })
            .buttonStyle(SecondaryButtonStyle())
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
    
    private func matchRegistrationTapped() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        withAnimation { showMatchRegistration.toggle() }
    }
}

private struct MatchRegistrationBottomView: View {
    
    @Binding var showMatchRegistration: Bool
    
    init(_ showMatchRegistration: Binding<Bool>) {
        self._showMatchRegistration = showMatchRegistration
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Button(action: closeButtonTapped, label: {
                Text("Close")
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(SecondaryButtonStyle())
        }
    }
    
    private func closeButtonTapped() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        withAnimation { showMatchRegistration.toggle() }
    }
}
