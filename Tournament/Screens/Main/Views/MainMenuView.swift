//
//  MainMenuView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import SwiftUI

struct MainMenuView: View {
    
    var body: some View {
        
        HStack {
            Button(action: leftButtonTapped) {
                Image(systemName: "signpost.left.circle")
                    .renderingMode(.template)
                    .imageScale(.large)
                    .font(Font.system(size: 22))
                    .foregroundStyle(Color.Text.normal)
            }
            .padding(.trailing, 8)
            
            Button(action: rightButtonTapped) {
                Image(systemName: "signpost.left.circle")
                    .renderingMode(.template)
                    .imageScale(.large)
                    .font(Font.system(size: 22))
                    .foregroundStyle(Color.Text.disabled)
            }
            .padding(.leading, 8)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
    
    private func leftButtonTapped() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    private func rightButtonTapped() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
