//
//  Account.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

struct Account: Codable, Identifiable {
    
    var id: UUID
    
    var tournamentId: UUID?
    
    var email: String
    
    var username: String
    
    var created: Date
    
    var accessToken: String?
    
    var refreshToken: String?
    
    var authenticated: Bool { accessToken != nil }
    
    var hasTournament: Bool { tournamentId != nil }
}
