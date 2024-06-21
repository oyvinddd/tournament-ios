//
//  AccountView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject var viewModel = AccountViewModel()
    @Binding var showProfile: Bool
    @State private var showSignOutAlert = false
    
    var body: some View {
        
        VStack {
            
            // top bar
            ZStack {
                
                Text("Account")
                    .font(Font.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(Color.Text.normal)
                
                HStack {
                    
                    Button("", systemImage: "xmark", action: closeButtonTapped)
                        .font(Font.system(size: 22, weight: .regular))
                        .foregroundStyle(Color.Text.normal.opacity(0.8))
                    
                    Spacer()
                }
            }
            .frame(alignment: .top)
            .padding(.top, 16)
            
            // account part
            if let account = viewModel.account {
                
                HStack {
                    
                    ZStack {
                        
                        Text(account.emoji)
                            .font(Font.system(size: 42))
                            .padding(.all, 6)
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(.green))
                    
                    VStack(alignment: .leading) {
                        Text(account.userName.lowercased())
                            .font(Font.system(size: 28, weight: .semibold))
                            .foregroundStyle(Color.Text.normal)
                        
                        Text("Some text here as well")
                            .font(Font.system(size: 18, weight: .medium))
                            .foregroundStyle(Color.Text.subtitle)
                    }
                    .padding(.leading, 8)
                    
                    Spacer()
                }
                .padding(.vertical, 16)
            }
            
            Divider()
            
            ProfileMenuView()
                .padding(.top, 16)
            
            Spacer()
            
            Button("Sign Out", action: signOutButtonTapped)
                .font(Font.system(size: 18, weight: .medium))
                .frame(maxWidth: .infinity)
                .foregroundStyle(.red)
                .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .background(.white)
        .alert(isPresented: $showSignOutAlert) {
            Alert(
                title: Text("Sign out"),
                message: Text("Are you sure you want to sign out?"),
                primaryButton: .destructive(Text("Yes"), action: confirmSignOutTapped),
                secondaryButton: .cancel()
            )
        }
    }
    
    private func signOutButtonTapped() {
        showSignOutAlert.toggle()
    }
    
    private func confirmSignOutTapped() {
        viewModel.signOut()
    }
    
    private func closeButtonTapped() {
        showProfile.toggle()
    }
}

private struct ProfileMenuView: View {
    
    var body: some View {
        
        VStack {
            
            HStack {
                Image(systemName: "person")
                    .font(Font.system(size: 18, weight: .medium))
                    .padding(.trailing, 8)
                    .opacity(0.5)
                Text("Manage account")
                    .font(Font.system(size: 18, weight: .medium))
                    .foregroundStyle(Color.Text.normal)
                Spacer()
            }
            .padding(.bottom, 18)
            
            HStack {
                Image(systemName: "gearshape")
                    .font(Font.system(size: 18, weight: .medium))
                    .padding(.trailing, 8)
                    .opacity(0.5)
                Text("Manage tournament")
                    .font(Font.system(size: 18, weight: .medium))
                    .foregroundStyle(Color.Text.normal)
                Spacer()
            }
            .padding(.bottom, 18)
            
            HStack {
                Image(systemName: "medal")
                    .font(Font.system(size: 18, weight: .medium))
                    .padding(.trailing, 8)
                    .opacity(0.5)
                Text("My achievements")
                    .font(Font.system(size: 18, weight: .medium))
                    .foregroundStyle(Color.Text.normal)
                Spacer()
            }
        }
    }
}
