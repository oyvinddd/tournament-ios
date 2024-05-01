//
//  UsernameRequest.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/04/2024.
//

import Foundation

struct UsernameRequest: Codable {
    
    var username: String
    
    init(_ username: String) {
        self.username = username
    }
}
