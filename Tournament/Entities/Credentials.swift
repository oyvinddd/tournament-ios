//
//  Credentials.swift
//  Tournament
//
//  Created by Øyvind Hauge on 31/05/2024.
//

import Foundation

struct Credentials: Codable {
    
    var account: Account
    
    var token: String
    
    init(_ account: Account, _ accessToken: String) {
        self.account = account
        self.token = accessToken
    }
}
