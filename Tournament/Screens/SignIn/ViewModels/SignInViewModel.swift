//
//  SignInViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation
import AuthenticationServices

@MainActor final class SignInViewModel: ObservableObject, AuthenticationServiceInjectable {
    
    func startGoogleSignIn(from contextProvider: ASWebAuthenticationPresentationContextProviding) {
    }
}
