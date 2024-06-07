//
//  BasicSignInView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 31/05/2024.
//

import SwiftUI

struct BasicSignInView: View {
    
    @ObservedObject var viewModel = SignInViewModel()
    
    @State private var showRegistration = false
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        if !showRegistration {
         
            VStack(spacing: 16) {
                Text("Welcome!")
                    .font(Font.system(size: 32, weight: .bold))
                    .foregroundStyle(Color.Text.normal)
                    .padding(.bottom, 16)
                
                TextField("Username", text: $username)
                    .textInputAutocapitalization(.never)
                    .font(Font.system(size: 18, weight: .bold))
                    .textFieldStyle(RoundedTextFieldStyle())
                
                TextField("Password", text: $password)
                    .textContentType(.password)
                    .font(Font.system(size: 18, weight: .bold))
                    .textFieldStyle(RoundedTextFieldStyle())
                
                Button(action: signInTapped) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(MainButtonStyle())
                
                Button(action: missingAccountTapped) {
                    Text("I don't have an account")
                        .font(Font.system(size: 18, weight: .bold))
                        .foregroundStyle(Color.General.main)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 16)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            
        } else {
            
            RegistrationView(
                username: $username,
                password: $password,
                registerAction: registrationTapped,
                backAction: backTapped
            )
        }
    }
    
    private func signInTapped() {
        viewModel.signIn(username, password)
    }
    
    private func registrationTapped() {
        viewModel.register(username, password)
    }
    
    private func missingAccountTapped() {
        username = ""
        password = ""
        showRegistration.toggle()
    }
    
    private func backTapped() {
        username = ""
        password = ""
        showRegistration.toggle()
    }
}

private struct RegistrationView: View {
    
    @Binding var username: String
    @Binding var password: String
    var registerAction: () -> Void
    var backAction: () -> Void
    
    var body: some View {
        
        VStack(spacing: 16) {
            Text("Register account")
                .font(Font.system(size: 32, weight: .bold))
                .foregroundStyle(Color.Text.normal)
                .padding(.bottom, 16)
            
            TextField("Preferred username", text: $username)
                .textInputAutocapitalization(.never)
                .font(Font.system(size: 18, weight: .bold))
                .textFieldStyle(RoundedTextFieldStyle())
            
            TextField("Preferred password", text: $password)
                .textContentType(.newPassword)
                .font(Font.system(size: 18, weight: .bold))
                .textFieldStyle(RoundedTextFieldStyle())
            
            Button(action: registerAction) {
                Text("Register")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(MainButtonStyle())
            
            Button(action: backAction) {
                Text("Back")
                    .font(Font.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.General.main)
            }
            .padding(.top, 16)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    BasicSignInView()
}
