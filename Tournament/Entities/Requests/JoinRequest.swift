//
//  JoinRequest.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/04/2024.
//

import Foundation

struct JoinRequest: Codable {
    
    var code: String
    
    init(_ code: String) {
        self.code = code
    }
}
