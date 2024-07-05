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
            backgroundColor = Color.General.mainBackground2
        } else {
            backgroundColor = Color.General.mainBackground2
        }
        
        return configuration.label
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .font(Font.system(size: 16, weight: .bold))
            .background(backgroundColor)
            .foregroundStyle(.white)
            .clipShape(Capsule(style: .continuous))
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        var backgroundColor: Color
        if configuration.isPressed {
            backgroundColor = .white
        } else {
            backgroundColor = .white
        }
        
        return configuration.label
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .font(Font.system(size: 19, weight: .bold))
            .background(backgroundColor)
            .foregroundStyle(Color.General.mainBackground2)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.General.mainBackground2, lineWidth: 2))
    }
}
