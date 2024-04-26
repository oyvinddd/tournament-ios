//
//  SignInViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

@MainActor final class SignInViewModel: ObservableObject, AccountServiceInjectable {
    
    func signInUsingGoogle() {
        // dummy account
        accountService.refreshAccount(Account(id: UUID(), username: "oyvind_h", created: Date.now, accessToken: "test_access_token", refreshToken: "test_refresh_token"))
    }
}
