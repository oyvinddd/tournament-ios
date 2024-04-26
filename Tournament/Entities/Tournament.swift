//
//  Tournament.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

enum ResetInterval: Int, Codable {
    case weekly, monthly, never
}

struct Tournament: Codable, Identifiable {
    
    var id: UUID
    
    var adminId: UUID
    
    var title: String
    
    var created: Date
    
    var scoreboard: [Player]
    
    var resetInterval: ResetInterval = .never
}
