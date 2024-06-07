//
//  ProfileView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel = ProfileViewModel()
    @State private var showSignOutAlert = false
    
    var body: some View {
        
        VStack {
            
            HStack {
                Button("", systemImage: "xmark") {
                }
                .font(Font.system(size: 22))
                .foregroundStyle(Color.Text.normal)
                .padding(.top, 16)
                
                Spacer()
                
                Text("Profile")
                    .font(Font.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(Color.Text.normal)
            }
            .frame(alignment: .top)
            .padding(.top, 16)
            
            Spacer()
            
            Button("Sign Out", action: signOutButtonTapped)
                .font(Font.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity)
                .foregroundStyle(.red)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .background(.white)
    }
    
    private func signOutButtonTapped() {
        viewModel.signOut()
    }
}
