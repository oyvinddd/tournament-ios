//
//  MainView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        
        ZStack {
            
            ScrollView(.horizontal) {
                
                LazyHStack(spacing: 0) {
                    
                    RegisterMatchView()
                        .containerRelativeFrame(.horizontal)
                    
                    TournamentView()
                        .containerRelativeFrame(.horizontal)
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .background(
                LinearGradient(
                    colors: [Color.General.mainBackground2, Color.General.mainBackground1],
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing
                )
            )
            
            VStack {
                Spacer()
                
                MainMenuView()
                    .frame(height: 50, alignment: .center)
                    .padding(.bottom, 32)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all, edges: .bottom)
        .sheet(isPresented: $viewModel.showSignIn) {
            SignInView()
                .interactiveDismissDisabled()
        }
    }
}
