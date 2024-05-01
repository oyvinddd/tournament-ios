//
//  SignInView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel = SignInViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                Spacer()
                
                Text("Welcome! ✨")
                    .font(Font.system(size: 38, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.Text.normal)
                
                NavigationLink("Sign in with Google", destination: ChooseUsernameView())
                    .buttonStyle(MainButtonStyle())
                    .padding(.horizontal, 32)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.General.background)
        }
    }
    
    private func googleButtonTapped() {
        viewModel.signInUsingGoogle()
    }
}
