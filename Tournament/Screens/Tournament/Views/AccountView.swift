//
//  AccountView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import SwiftUI

struct AccountView: View {
    
    @State var showSettingsDialog: Bool = false
    
    var account: Account
    var buttonAction: () -> Void
    
    var body: some View {
        
        VStack {
            
            ZStack {
                Text("🤩")
                    .font(Font.system(size: 64))
                    .padding(.all, 8)
            }
            .background(Circle().fill(.red))
            .padding(.bottom, 8)
            
            Text(account.username)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(Font.system(size: 28, weight: .medium, design: .rounded))
                .foregroundStyle(Color.Text.normal)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}
