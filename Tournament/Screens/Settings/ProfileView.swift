//
//  ProfileView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel = ProfileViewModel()
    @Binding var showProfile: Bool
    @State private var showSignOutAlert = false
    
    var body: some View {
        
        VStack {
            
            // top bar
            HStack {
                
                Button("", systemImage: "xmark", action: closeButtonTapped)
                    .background(.yellow)
                    .font(Font.system(size: 22))
                    .foregroundStyle(Color.Text.normal)
                
                Spacer()
                
                Text("Profile")
                    .font(Font.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(.red)
                    .foregroundStyle(Color.Text.normal)
            }
            .frame(alignment: .top)
            .padding(.top, 16)
            
            // account part
            if let account = viewModel.account {
                
                HStack {
                    
                    ZStack {
                        
                        Text("😍")
                            .font(Font.system(size: 48))
                            .padding(.all, 6)
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(.green))
                    
                    Text(account.username.lowercased())
                        .font(Font.system(size: 20))
                        .foregroundStyle(Color.Text.normal)
                    
                    Spacer()
                }
                .padding(.vertical, 16)
            }
            
            Divider()
            
            Spacer()
            
            Button("Sign Out", action: signOutButtonTapped)
                .font(Font.system(size: 18, weight: .semibold))
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
