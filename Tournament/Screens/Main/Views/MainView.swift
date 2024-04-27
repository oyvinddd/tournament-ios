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
            
            CameraView()
            
            ScrollView(.horizontal) {
                
                LazyHStack(spacing: 0) {
                    
                    PlaceholderView()
                        .containerRelativeFrame(.horizontal)
                    
                    TournamentView()
                        .containerRelativeFrame(.horizontal)
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .background(Color.General.background)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.ignoresSafeArea(.all)
        .background(.white)
        .sheet(isPresented: $viewModel.showSignIn) {
            SignInView()
                .interactiveDismissDisabled()
        }
    }
}
