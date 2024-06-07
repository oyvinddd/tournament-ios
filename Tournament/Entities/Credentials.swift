//
//  Credentials.swift
//  Tournament
//
//  Created by Øyvind Hauge on 31/05/2024.
//

import Foundation

struct Credentials: Codable {
    
    init(_ account: Account, _ accessToken: String) {
        self.account = account
        self.accessToken = accessToken
    }
    
    var account: Account
    
    var accessToken: String
}
