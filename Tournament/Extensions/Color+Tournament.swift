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
        
        static let background = Color(hex: 0x7371fc)
        
        static let mainBackground1 = Color(hex: 0xAE86EF)
        
        static let mainBackground2 = Color(hex: 0x6967E1)
        
        static let main = Color(hex: 0x656FED)
        
        static let mainDark = Color(hex: 0x4C56C8)
        
        static let separator = Color(hex: 0xF1F0F2)
        
        static let pointsBackground = Color(hex: 0xD587B6)
        
        static let totalWinsBackground = Color(hex: 0x8C77CE)
        
        static let playerBackground = Color(hex: 0xECECEC)
        
        static let error = Color(hex: 0xD14936)
        
        static let warning = Color(.yellow)
        
        static let success = Color(.green)
    }
    
    enum Text {
        
        static let normal = Color(hex: 0x313443)
        
        static let subtitle = Color(hex: 0x9D9D9D)
        
        static let disabled = Color(hex: 0x9FA1A4)
    }
}
