//
//  ServiceFactory.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

protocol ServiceFactoryProtocol {
    
    var authenticationService: AuthenticationService { get }
    
    var tokenService: TokenService { get }
    
    var accountService: AccountService { get }
    
    var tournamentService: TournamentService { get }
    
    var playerDiscoveryService: PlayerDiscoveryService { get }
    
    var playerBroadcastService: PlayerBroadcastService { get }
}

struct LiveServiceFactory: ServiceFactoryProtocol {
    
    static let instance = LiveServiceFactory()
    
    var authenticationService: AuthenticationService { MockedAuthenticationService() }
    
    var tokenService: TokenService { MockedTokenService() }
    
    var accountService: AccountService { LiveAccountService.shared }
    
    var tournamentService: TournamentService { MockedTournamentService.shared }
    
    var playerDiscoveryService: PlayerDiscoveryService { LivePlayerDiscoveryService() }
    
    var playerBroadcastService: PlayerBroadcastService { LivePlayerBroadcastService.shared }
}
