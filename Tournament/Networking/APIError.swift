//
//  APIError.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import Foundation

enum APIError: Error {
    
    case unauthorized
    
    case noTournament
    
    case invalidResponse
    
    case decodingFailed
}
