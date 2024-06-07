//
//  SignInViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation
import AuthenticationServices

enum SignInState {
    case idle
    case loading
    case signedIn(Credentials)
    case failure(Error)
}

@MainActor final class SignInViewModel: ObservableObject,
                                        AuthenticationServiceInjectable,
                                        AccountServiceInjectable {
    
    @Published var state: SignInState = .idle
    
    func signIn(_ username: String, _ password: String) {
        Task {
            
            do {
                
                let credentials = try await authenticationService.signIn(username, password)
                var account = credentials.account
                account.accessToken = credentials.accessToken
                accountService.set(account: account)
                
                state = .signedIn(credentials)
                
            } catch let error {
                state = .failure(error)
                print(error)
            }
        }
    }
    
    func register(_ username: String, _ password: String) {
        Task {
            
            do {
                
                let credentials = try await authenticationService.register(username, password)
                var account = credentials.account
                account.accessToken = credentials.accessToken
                accountService.set(account: account)
                
                state = .signedIn(credentials)
                
            } catch let error {
                state = .failure(error)
            }
        }
    }
}
