//
//  CredentialService.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/04/2024.
//

import Foundation

protocol CredentialServiceInjectable {
    var credentialService: CredentialService { get }
}

extension CredentialServiceInjectable {
    var credentialService: CredentialService { MockServiceFactory.instance.credentialService }
}

protocol CredentialService {
    
    var accessToken: String? { get }
    
    var refreshToken: String? { get }
}

final class MockCredentialService: CredentialService {
    
    static let shared = MockCredentialService()
    
    var accessToken: String?
    
    var refreshToken: String?
}
