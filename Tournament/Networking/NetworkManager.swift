//
//  NetworkManager.swift
//  Tournament
//
//  Created by Øyvind Hauge on 09/04/2024.
//

import Foundation

protocol NetworkManagerInjectable {
    
    var networkManager: NetworkManager { get }
}

extension NetworkManagerInjectable {
    
    var networkManager: NetworkManager { return NetworkManager() }
}

final class NetworkManager {
    
    private let session: URLSession
    
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    init(urlSession: URLSession = URLSession.shared) {
        self.session = urlSession
    }
    
    func execute<T: Decodable>(request: URLRequest) async throws -> T {
        printRequest(request)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        // TODO: need a mapping function here to handle the individual http codes
        guard 200 ..< 300 ~= httpResponse.statusCode else {
            throw APIError.invalidResponse
        }
        
        do {
            
            return try jsonDecoder.decode(T.self, from: data)
            
        } catch _ {
            
            throw APIError.decodingFailed
        }
    }
    
    func execute(request: URLRequest) async throws {
        printRequest(request)
        
        let (_, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        // TODO: need a mapping function here to handle the individual http codes
        guard 200 ..< 300 ~= httpResponse.statusCode else {
            throw APIError.invalidResponse
        }
    }
    
    private func printRequest(_ request: URLRequest) {
        print("✨ [\(request.httpMethod!.uppercased())] \(request.url!.absoluteString)")
    }
}
