//
//  ProfileView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel = ProfileViewModel()
    
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
            
            Button("Sign Out", action: signOutButtonTapped)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.red)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .background(.white)
    }
    
    private func signOutButtonTapped() {}
}
