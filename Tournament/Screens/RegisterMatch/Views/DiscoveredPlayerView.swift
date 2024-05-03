//
//  DiscoveredPlayerView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import SwiftUI

struct DiscoveredPlayerView: View {
    
    var player: Player
    
    init(_ player: Player) {
        self.player = player
    }
    
    var body: some View {
        
        VStack {
            ZStack {
                ZStack {
                    Text("🤩")
                        .font(Font.system(size: 32))
                        .frame(alignment: .center)
                        .padding(.all, 8)
                }
                .padding(.all, 2)
                .background(Circle().fill(.blue))
            }
            .padding(.all, 4)
            .background(Circle().fill(.white))
            .shadow(color: .white, radius: 5)
            
            Text(player.username)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
                .font(Font.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(Color.Text.normal)
        }
    }
}
