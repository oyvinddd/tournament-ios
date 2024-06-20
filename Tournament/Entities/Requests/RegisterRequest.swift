//
//  RegisterRequest.swift
//  Tournament
//
//  Created by Øyvind Hauge on 20/06/2024.
//

import Foundation

struct RegisterRequest: Encodable {
    
    var email: String
    
    var userName: String
    
    var password: String
    
    init(_ email: String, _ userName: String, _ password: String) {
        self.email = email
        self.userName = userName
        self.password = password
    }
}
