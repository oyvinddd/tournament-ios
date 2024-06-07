//
//  SignInRequest.swift
//  Tournament
//
//  Created by Øyvind Hauge on 31/05/2024.
//

import Foundation

struct SignInOrRegistrationRequest: Encodable {
    
    var username: String
    
    var password: String
    
    init(_ username: String, _ password: String) {
        self.username = username
        self.password = password
    }
}
