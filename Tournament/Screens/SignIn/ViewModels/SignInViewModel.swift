//
//  SignInViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation
import AuthenticationServices

@MainActor final class SignInViewModel: ObservableObject, AuthenticationServiceInjectable {
    
    @Published var credentials: Credentials?
    
    func basicSignIn(_ username: String, _ password: String) {
        Task {
            do {
                credentials = try await authenticationService.basicSignIn(username, password)
            } catch let error {
                print(error)
            }
        }
    }
}
