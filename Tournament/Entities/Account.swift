//
//  Account.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

struct Account: Codable, Identifiable {
    
    var id: UUID
    
    var email: String
    
    var userName: String
    
    var totalMatchesPlayed: Int
    
    var totalMatchesWon: Int
    
    var createdDate: String
    
    var updatedDate: String
    
    var tournamentAccounts: [TournamentAccount]?
}

extension Account {
    
    var emoji: String { Emoji.emojiFromId(id) }
}
