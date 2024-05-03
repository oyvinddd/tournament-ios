//
//  AccountService.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

protocol AccountServiceInjectable {
    var accountService: AccountService { get }
}

extension AccountServiceInjectable {
    var accountService: AccountService { MockServiceFactory.instance.accountService }
}

protocol AccountService {
    
    var account: Account? { get }
    
    var accessToken: String? { get }
    
    var authenticated: Bool { get }
    
    func refreshAccount(_ account: Account)
    
    func updateUsername(_ username: String) async throws -> Account
}

final class LiveAccountService: AccountService, RequestFactoryInjectable, NetworkManagerInjectable {

    var account: Account?
    
    var accessToken: String?
    
    var authenticated: Bool { accessToken != nil }
    
    func refreshAccount(_ account: Account) {
    }
    
    func updateUsername(_ username: String) async throws -> Account {
        let request = requestFactory.updateUsernameRequest(username)
        return try await networkManager.execute(request: request)
    }
}

final class MockedAccountService: AccountService, RequestFactoryInjectable {
    
    static let shared = MockedAccountService()
    
    var account: Account? = Account(id: UUID(), username: "oyvind_h", created: Date.now, accessToken: "test_access_token", refreshToken: "test_refresh_token")
    
    var accessToken: String? { account?.accessToken }
    
    var authenticated: Bool { account?.authenticated ?? false }
    
    func refreshAccount(_ account: Account) {
        self.account = account
    }
    
    func updateUsername(_ username: String) async throws -> Account {
        return Account(id: UUID(), username: "test", created: Date.now)
    }
}
