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
    
    var scoreboard: [String] = ["1", "2", "3", "abc", "", "", "", "", ""]
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                // header view
                HStack {
                    Text("Tietoevry Bordtennis")
                        .font(Font.system(size: 26, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    Button(action: profileButtonTapped) {
                        ZStack {
                            
                            Text("😄")
                                .font(Font.system(size: 24))
                                .padding(.all, 6)
                        }
                        
                        .background(RoundedRectangle(cornerRadius: 10).fill(.green))
                    }
                }
                .padding(.horizontal, 16)
                
                // tournament view
                VStack {
                    
                    // scoreboard
                    List {
                        
                        ForEach(scoreboard.indices, id: \.self) { index in
                            PlayerView(index: index)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .padding(.horizontal, 16)
                                .background(.white)
                        }
                    }
                    .listStyle(.plain)
                    .listRowSpacing(20)
                    .contentMargins(.top, 16)
                    
                    Spacer()
                    
                    // bottom menu
                    ZStack {
                        Button(action: {}) {
                            Text("Button")
                        }
                        .background(.yellow)
                        .safeAreaPadding(.bottom)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
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
            SettingsView()
        }
    }
    
    private func profileButtonTapped() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        showProfile.toggle()
    }
}

private struct PlayerView: View {
    
    let index: Int
    
    var body: some View {
        
        HStack {
            
            Text("\(index + 1)")
                .font(Font.system(size: 17, weight: .heavy))
                .foregroundStyle(Color.Text.subtitle)
                .padding(.trailing, 8)
            
            ZStack {
                Text("🤩")
                    .font(Font.system(size: 24))
                    .padding(.all, 6)
            }
            .background(RoundedRectangle(cornerRadius: 8).fill(.gray))
            .padding(.trailing, 8)
            
            VStack {
                
                Text("oyvind_h")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(size: 19, weight: .bold))
                    .padding(.bottom, 1)
                    .foregroundStyle(Color.Text.normal)
                
                Text("1800 pts")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(size: 15, weight: .bold))
                    .foregroundStyle(Color.Text.subtitle)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            Text("3")
                .font(Font.system(size: 17, weight: .bold))
                .foregroundStyle(Color.Text.normal)
            
            Text("3")
                .font(Font.system(size: 17, weight: .bold))
                .foregroundStyle(Color.Text.normal)
                .padding(.leading, 26)
        }
    }
}

#Preview {
    HomeView()
}
