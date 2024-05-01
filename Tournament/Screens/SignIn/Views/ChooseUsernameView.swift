//
//  ChooseUsernameView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/04/2024.
//

import SwiftUI

struct ChooseUsernameView: View {
    
    @ObservedObject var viewModel = ChooseUsernameViewModel()
    
    @State var username: String = ""
    
    var body: some View {
        
        VStack {
            Text("Choose a username")
                .foregroundStyle(Color.Text.normal)
            
            TextField("Username...", text: $username)
                .textFieldStyle(RoundedTextFieldStyle())
                .padding(.horizontal, 32)
            
            Button("Continue", action: usernameButtonTapped)
                .buttonStyle(MainButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.General.background)
    }
    
    private func usernameButtonTapped() {
        viewModel.chooseUsername(username)
    }
}
