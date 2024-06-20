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
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        if !showRegistration {
         
            VStack(spacing: 16) {
                Text("Hello!👋")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(size: 28, weight: .bold))
                    .foregroundStyle(Color.Text.normal)
                
                Text("Sign in or register an account to get started")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.Text.subtitle)
                    .padding(.bottom, 16)
                
                TextField("Email or username", text: $username)
                    .textInputAutocapitalization(.never)
                    .font(Font.system(size: 18, weight: .bold))
                    .textFieldStyle(RoundedTextFieldStyle())
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .font(Font.system(size: 18, weight: .bold))
                    .textFieldStyle(RoundedTextFieldStyle())
                
                Button(action: signInTapped) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(MainButtonStyle())
                .padding(.horizontal, 64)
                .padding(.top, 16)
                
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
            .padding(.horizontal, 32)
            
        } else {
            
            RegistrationView(
                email: $email,
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
    
    @Binding var email: String
    @Binding var username: String
    @Binding var password: String
    var registerAction: () -> Void
    var backAction: () -> Void
    
    var body: some View {
        
        VStack(spacing: 16) {
            Text("Register account")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.system(size: 28, weight: .bold))
                .foregroundStyle(Color.Text.normal)
                .padding(.bottom, 16)
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .font(Font.system(size: 18, weight: .bold))
                .textFieldStyle(RoundedTextFieldStyle())
            
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
            .padding(.horizontal, 64)
            .padding(.top, 16)
            
            Button(action: backAction) {
                Text("Back")
                    .font(Font.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.General.main)
            }
            .padding(.top, 16)
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    BasicSignInView()
}
