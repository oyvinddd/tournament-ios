//
//  AuthenticationService.swift
//  Tournament
//
//  Created by Øyvind Hauge on 03/05/2024.
//

import Foundation
import AuthenticationServices

protocol AuthenticationServiceInjectable {
    var authenticationService: AuthenticationService { get }
}

extension AuthenticationServiceInjectable {
    var authenticationService: AuthenticationService { LiveServiceFactory.instance.authenticationService }
}

protocol AuthenticationService {
    
    var googleAuthUrl: URL { get }
    
    var appleAuthUrl: URL { get }
    
    func startGoogleSignIn(from contextProvider: ASWebAuthenticationPresentationContextProviding)
}

final class LiveAuthenticationService: AuthenticationService, RequestFactoryInjectable {
    
    var googleAuthUrl: URL { requestFactory.googleAuthUrl }
    
    var appleAuthUrl: URL { requestFactory.appleAuthUrl }
    
    func startGoogleSignIn(from contextProvider: ASWebAuthenticationPresentationContextProviding) {
        
        let callback = ASWebAuthenticationSession.Callback.customScheme("anchorage")
        let session = ASWebAuthenticationSession(url: googleAuthUrl, callback: callback, completionHandler: handleAuthenticationCallback)
        session.presentationContextProvider = contextProvider
        session.start()
    }
    
    private func handleAuthenticationCallback(_ callbackUrl: URL?, error: Error?) {
        guard let url = callbackUrl, let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return
        }
        
        guard let queryItems = components.queryItems else {
            return
        }
        
        // extract access and refresh tokens from the redirect url
        let accessToken = queryItems.first(where: { $0.name == "access_token" })?.value
        let refreshToken = queryItems.first(where: { $0.name == "refresh_token" })?.value
        
        // we can now store the refresh and access tokens in the iOS keychain for later use
        //_ = tokenService.store(tokens: TokenContainer(accessToken, refreshToken))
        
        // lastly, we notify the system that the user was successfully authenticated
        //NotificationCenter.default.post(name: .signInSuccess)
    }
}
