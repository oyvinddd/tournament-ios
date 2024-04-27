//
//  Color+Tournament.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

extension Color {
    
    init(hex: UInt, alpha: Double = 1) {
        
        let r = Double((hex >> 16) & 0xff) / 255
        let g = Double((hex >> 08) & 0xff) / 255
        let b = Double((hex >> 00) & 0xff) / 255
        
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
    
    enum General {
        static let background = Color(hex: 0xE4E6EB)
        
        static let main = Color(hex: 0x656FED)
        
        static let mainDark = Color(hex: 0x4C56C8)
        
        static let separator = Color(hex: 0xF1F0F2)
        
        static let pointsBackground = Color(hex: 0xD587B6)
        
        static let totalWinsBackground = Color(hex: 0x8C77CE)
    }
    
    enum Text {
        static let normal = Color(hex: 0x545A66)
        
        static let subtitle = Color(hex: 0xC7C7C9)
        
        static let disabled = Color(hex: 0x9FA1A4)
    }
}
