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
    
    var authenticated: Bool { get }
    
    var accessToken: String? { get }
    
    func refreshAccount(_ account: Account)
}

final class MockedAccountService: AccountService {

    static let shared = MockedAccountService()
    
    var account: Account? = Account(id: UUID(), username: "oyvind_h", created: Date.now, accessToken: "test_access_token", refreshToken: "test_refresh_token")
    
    var accessToken: String? { account?.accessToken }
    
    var authenticated: Bool { account?.authenticated ?? false }
    
    func refreshAccount(_ account: Account) {
        self.account = account
    }
}
