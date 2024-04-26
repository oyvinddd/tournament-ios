//
//  InvitePlayer.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct InvitePlayer: View {
    
    @State var username = ""
    
    var body: some View {
        VStack {
            
            Text("Invite Player")
                .font(Font.system(size: 28, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Search for a player...", text: $username)
                .font(Font.system(size: 18, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity)
                .backgroundStyle(.gray)
            
            Spacer()
        }
        .padding(.all, 32)
    }
}
