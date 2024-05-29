//
//  AccountService.swift
//  Tournament
//
//  Created by Øyvind Hauge on 29/05/2024.
//

import Foundation

protocol AccountServiceInjectable {
    
    var accountService: AccountService { get }
}

extension AccountServiceInjectable {
    
    var accountService: AccountService { LiveServiceFactory.instance.accountService }
}

protocol AccountService {
    
    var account: Account? { get }
    
    var accessToken: String? { get }
}

final class LiveAccountService: AccountService {
    
    static let shared = LiveAccountService()
    
    var account: Account? {
        return Account(
            id: UUID(uuidString: "43c9f799-55c1-45e6-ab25-1df1f55cd9cb")!,
            email: "user@test1.com",
            username: "user1",
            created: Date.now
        )
    }
    
    var accessToken: String? { account?.accessToken }
}
