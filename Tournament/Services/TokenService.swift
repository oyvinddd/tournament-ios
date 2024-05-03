//
//  CredentialService.swift
//  Tournament
//
//  Created by Øyvind Hauge on 11/04/2024.
//

import Foundation

protocol TokenServiceInjectable {
    
    var tokenService: TokenService { get }
}

extension TokenServiceInjectable {
    
    var tokenService: TokenService { return MockServiceFactory.instance.tokenService }
}

protocol TokenService {
    
    var tokens: TokenContainer? { get }
    
    var accessToken: String? { get }
    
    var authenticated: Bool { get }
    
    func store(tokens: TokenContainer) -> Bool
    
    func clear() -> Bool
}

final class LiveTokenService: TokenService {

    static let shared = LiveTokenService()
    
    var tokens: TokenContainer? = try? KeychainWrapper.load(key: "tokens")
    
    var accessToken: String? { tokens?.accessToken }
    
    var authenticated: Bool { tokens?.accessToken != nil }
    
    init() {
        
    }
    
    func store(tokens: TokenContainer) -> Bool {
        do {
            
            let stored = try KeychainWrapper.store(tokens, for: "tokens")
            if stored {
                self.tokens = tokens
            }
            return stored
            
        } catch _ {
            
            return false
        }
    }
    
    func clear() -> Bool {
        guard KeychainWrapper.delete(key: "tokens") else {
            return false
        }
        tokens = nil
        return true
    }
}

final class MockedTokenService: TokenService {
    
    static let shared = MockedTokenService()
    
    var tokens: TokenContainer? = try? KeychainWrapper.load(key: "tokens")
    
    var accessToken: String? { tokens?.accessToken }
    
    var authenticated: Bool { tokens?.accessToken != nil }
    
    func store(tokens: TokenContainer) -> Bool {
        do {
            
            let stored = try KeychainWrapper.store(tokens, for: "tokens")
            if stored {
                self.tokens = tokens
            }
            return stored
            
        } catch _ {
            
            return false
        }
    }
    
    func clear() -> Bool {
        guard KeychainWrapper.delete(key: "tokens") else {
            return false
        }
        self.tokens = nil
        return true
    }
}
