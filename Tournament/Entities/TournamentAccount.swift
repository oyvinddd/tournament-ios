//
//  TournamentAccount.swift
//  Tournament
//
//  Created by Øyvind Hauge on 21/06/2024.
//

import Foundation

struct TournamentAccount: Codable {
    
    var id: UUID
    
    var userName: String
    
    var score: Int
    
    var matchesPlayed: Int
    
    var matchesWon: Int
}
