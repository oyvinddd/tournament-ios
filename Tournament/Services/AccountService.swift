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
    
    var signedIn: Bool { get }
    
    func set(account: Account)
}

final class LiveAccountService: AccountService {

    static let shared = LiveAccountService()
    
    var account: Account?
    
    var accessToken: String? { account?.accessToken }
    
    var signedIn: Bool = false
    
    func set(account: Account) {
        self.account = account
        self.signedIn = true
    }
}
