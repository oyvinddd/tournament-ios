//
//  BasicSignInView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 31/05/2024.
//

import SwiftUI

struct BasicSignInView: View {
    
    @ObservedObject var viewModel = SignInViewModel()
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        VStack {
            Text("Welcome!")
                .font(Font.system(size: 32, weight: .bold))
                .foregroundStyle(Color.Text.normal)
            
            TextField("Username", text: $username)
                .font(Font.system(size: 18, weight: .bold))
                .textFieldStyle(.roundedBorder)
            
            TextField("Password", text: $password)
                .font(Font.system(size: 18, weight: .bold))
                .textFieldStyle(.roundedBorder)
            
            Button(action: signInTapped) {
                Text("Sign In")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(MainButtonStyle())
        }
        .padding(.horizontal, 16)
    }
    
    private func signInTapped() {
        viewModel.basicSignIn(username, password)
    }
}

#Preview {
    BasicSignInView()
}
