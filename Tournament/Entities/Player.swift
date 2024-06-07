//
//  Player.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

struct Player: Codable, Identifiable {
    
    var id: UUID
    
    var username: String
    
    var score: Int
    
    var matchesPlayed: Int
    
    var matchesWon: Int
    
    var emoji: String { Emoji.emojiFromId(id) }
}
