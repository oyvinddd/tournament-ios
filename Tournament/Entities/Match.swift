//
//  Match.swift
//  Tournament
//
//  Created by Øyvind Hauge on 29/05/2024.
//

import Foundation

struct Match: Codable, Identifiable {
    
    var id: UUID
    
    var winnerId: UUID
    
    var loserId: UUID
    
    var winnerDelta: Int
    
    var loserDelta: Int
    
    var date: Date
}
