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
    
    var bluetoothService: BluetoothService { get }
}

struct LiveServiceFactory: ServiceFactoryProtocol {
    
    static let instance = LiveServiceFactory()
    
    var authenticationService: AuthenticationService { LiveAuthenticationService() }
    
    var tokenService: TokenService { MockedTokenService() }
    
    var accountService: AccountService { LiveAccountService.shared }
    
    var tournamentService: TournamentService { LiveTournamentService() }
    
    var bluetoothService: BluetoothService { LiveBluetoothService() }
}
