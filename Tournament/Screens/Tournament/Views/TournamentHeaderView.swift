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
            
            VStack(spacing: 4) {
                
                Text(title)
                    .font(Font.system(size: 22, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.black)
                
                Text("22 players")
                    .font(Font.system(size: 18, weight: .bold, design: .rounded))
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
    }
    
    private func settingsButtonTapped() {
        
    }
}
