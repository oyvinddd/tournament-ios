//
//  MatchRequest.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/04/2024.
//

import Foundation

struct MatchRequest: Codable {
    
    var opponentId: UUID
    
    init(_ opponentId: UUID) {
        self.opponentId = opponentId
    }
}
