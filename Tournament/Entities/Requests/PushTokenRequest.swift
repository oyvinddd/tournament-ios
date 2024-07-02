//
//  PushTokenRequest.swift
//  Tournament
//
//  Created by Øyvind Hauge on 02/07/2024.
//

import Foundation

struct PushTokenRequest: Encodable {
    
    let token: String
    
    init(_ token: String) {
        self.token = token
    }
}
