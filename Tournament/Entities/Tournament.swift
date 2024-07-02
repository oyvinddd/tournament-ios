//
//  Tournament.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

enum ResetInterval: Int, Codable {
    case weekly = 0, monthly = 1, never = 2
}

struct Tournament: Codable, Identifiable {
    
    var id: UUID
    
    var adminId: UUID
    
    var title: String
    
    var isActive: Bool
    
    var tournamentAccounts: [Player]
    
    var scoreboard: [Player] {
        return tournamentAccounts.sorted(by: { $0.score > $1.score })
    }
}
