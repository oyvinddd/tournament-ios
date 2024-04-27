//
//  PlayerView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct PlayerView: View {
    
    var player: Player
    
    var body: some View {
        
        HStack {
            
            ZStack {
                Text("😍")
                    .font(Font.system(size: 22))
                    .frame(alignment: .center)
                    .padding(.all, 8)
            }
            .background(Ellipse().fill(.red))
            
            VStack(spacing: 4) {
                Text(player.username)
                    .font(Font.system(size: 20, weight: .medium, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.black)
                
                Text("\(player.score) pts")
                    .font(Font.system(size: 14, weight: .medium, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Text("#1")
                .font(Font.system(size: 22, weight: .bold, design: .rounded))
                .frame(alignment: .trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}
