//
//  SignInRequest.swift
//  Tournament
//
//  Created by Øyvind Hauge on 31/05/2024.
//

import Foundation

struct SignInRequest: Encodable {
    
    var loginDetails: String
    
    var password: String
    
    init(_ loginDetails: String, _ password: String) {
        self.loginDetails = loginDetails
        self.password = password
    }
}
