//
//  TournamentError.swift
//  Tournament
//
//  Created by Øyvind Hauge on 02/07/2024.
//

import Foundation

struct TournamentError: Error, Decodable {
    
    let type: String
    
    let title: String
    
    let status: Int
    
    let errors: ErrorContainer?
    
    let traceId: String?
}

struct ErrorContainer: Decodable {
    
    let code: String
    
    let description: String
    
    let errorType: Int
}
