//
//  ConfirmRegisterMatchView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/04/2024.
//

import SwiftUI

struct ConfirmRegisterMatchView: View {
    
    var body: some View {
        VStack {
            
            Text("Register Win")
                .font(Font.system(size: 32, weight: .bold, design: .rounded))
            
            Button("Register", action: confirmRegisterMatchTapped)
                .frame(maxWidth: .infinity)
                .buttonStyle(BorderedButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func confirmRegisterMatchTapped() {
        
    }
}
