//
//  ButtonStyle.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/04/2024.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        var backgroundColor: Color
        if configuration.isPressed {
            backgroundColor = Color.black
        } else {
            backgroundColor = Color.black
        }
        
        return configuration.label
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .font(Font.system(size: 19, weight: .bold, design: .rounded))
            .background(backgroundColor)
            .foregroundStyle(Color.white)
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
}
