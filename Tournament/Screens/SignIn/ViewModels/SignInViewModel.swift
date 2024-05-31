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

@MainActor final class SignInViewModel: ObservableObject, AuthenticationServiceInjectable {
    
    @Published var state: SignInState = .idle
    
    func basicSignIn(_ username: String, _ password: String) {
        Task {
            
            do {
                
                let credentials = try await authenticationService.basicSignIn(username, password)
                state = .signedIn(credentials)
                
            } catch let error {
                state = .failure(error)
            }
        }
    }
}
