//
//  TournamentHeaderView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct TournamentHeaderView: View {
    
    var title: String
    
    var body: some View {
        
        HStack {
            
            VStack(spacing: 6) {
                
                Text(title)
                    .font(Font.system(size: 22, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.Text.normal)
                
                Text("22 players • 5 days until reset")
                    .font(Font.system(size: 16, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Button(action: settingsButtonTapped) {
                Image(systemName: "ellipsis.circle")
                    .foregroundStyle(.gray)
                    .imageScale(.large)
            }
        }
        .padding(.all, 16)
        .background(.white)
        .clipShape(.rect(topLeadingRadius: 8, topTrailingRadius: 8))
    }
    
    private func settingsButtonTapped() {
        
    }
}
