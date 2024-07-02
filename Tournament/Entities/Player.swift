//
//  Player.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

struct Player: Codable, Identifiable {
    
    var id: UUID
    
    var tournamentId: UUID
    
    var accountId: UUID
    
    var username: String
    
    var score: Int
    
    var matchesWon: Int
    
    var matchesPlayed: Int
    
    var emoji: String { Emoji.emojiFromId(id) }
}
