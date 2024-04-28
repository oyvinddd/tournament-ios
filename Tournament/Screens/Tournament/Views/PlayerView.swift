//
//  PlayerView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct PlayerView: View {
    
    var player: Player
    var placement: Int
    var isFirst: Bool
    var isLast: Bool
    
    init(_ player: Player, placement: Int, isFirst: Bool, isLast: Bool) {
        self.player = player
        self.placement = placement
        self.isFirst = isFirst
        self.isLast = isLast
    }
    
    private let cornerRadius: Double = 8
    
    var body: some View {
        
        HStack {
            
            ZStack {
                Text("😍")
                    .font(Font.system(size: 22))
                    .frame(alignment: .center)
                    .padding(.all, 8)
            }
            .background(Ellipse().fill(.red))
            .padding(.leading, 8)
            .padding(.top, isFirst ? cornerRadius * 2 : 8)
            .padding(.bottom, isLast ? cornerRadius * 2 : 8)
            
            VStack(spacing: 2) {
                Text(player.username)
                    .font(Font.system(size: 22, weight: .medium, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.Text.normal)
                
                Text("\(player.score) points")
                    .font(Font.system(size: 14, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.Text.subtitle)
            }
            
            Spacer()
            
            Text(placementString())
                .font(Font.system(size: 18, weight: .bold, design: .rounded))
                .frame(width: 30, alignment: .center)
                .padding(.trailing, 8)
        }
        .frame(maxHeight: .infinity)
        .listRowBackground(Color.clear)
        .background(.white)
        .clipShape(
            .rect(
                topLeadingRadius: isFirst ? cornerRadius : 0,
                bottomLeadingRadius: isLast ? cornerRadius : 0,
                bottomTrailingRadius: isLast ? cornerRadius : 0,
                topTrailingRadius: isFirst ? cornerRadius : 0
            )
        )
    }
    
    private func placementString() -> String {
        if placement == 0 {
            return "🥇"
        }
        if placement == 1 {
            return "🥈"
        }
        if placement == 2 {
            return "🥉"
        }
        return "\(placement + 1)"
    }
}
