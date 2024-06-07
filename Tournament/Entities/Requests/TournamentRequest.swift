//
//  TournamentRequest.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/04/2024.
//

import Foundation

struct TournamentRequest: Codable {
    
    var title: String
    
    var interval: ResetInterval
    
    init(_ title: String, _ interval: ResetInterval = .never) {
        self.title = title
        self.interval = interval
    }
}
