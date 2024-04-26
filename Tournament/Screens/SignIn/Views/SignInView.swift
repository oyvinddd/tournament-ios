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
        
        VStack {
            
            Text("Welcome to Tournament!")
                .font(Font.system(size: 32, weight: .bold, design: .rounded))
            
            Spacer()
            
            Button("Sign in with Google", action: googleButtonTapped)
                .padding(.horizontal, 32)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
    
    private func googleButtonTapped() {
        viewModel.signInUsingGoogle()
    }
}
