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
    
    private let session = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    
    func execute<T: Decodable>(request: URLRequest) async throws -> T {
        printRequest(request)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        printResponse(httpResponse)
        
        // TODO: need a mapping function here to handle the individual http codes
        guard 200 ..< 300 ~= httpResponse.statusCode else {
            throw APIError.invalidResponse
        }
        
        do {
            
            return try jsonDecoder.decode(T.self, from: data)
            
        } catch let error {
            print(error)
            
            throw APIError.decodingFailed
        }
    }
    
    func execute(request: URLRequest) async throws {
        printRequest(request)
        
        let (_, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        printResponse(httpResponse)
        
        // TODO: need a mapping function here to handle the individual http codes
        guard 200 ..< 300 ~= httpResponse.statusCode else {
            throw APIError.invalidResponse
        }
    }
    
    private func printRequest(_ request: URLRequest) {
        guard let method = request.httpMethod, let url = request.url else {
            return
        }
        print("⬆️ [REQ] \(method.uppercased()) \(url.path())")
    }
    
    private func printResponse(_ response: HTTPURLResponse) {
        guard let url = response.url else {
            return
        }
        print("⬇️ [RES] HTTP \(response.statusCode) for \(url.path())")
    }
}
