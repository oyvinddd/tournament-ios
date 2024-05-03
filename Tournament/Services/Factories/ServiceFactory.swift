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
    var credentialService: CredentialService { get }
}

final class MockServiceFactory: ServiceFactoryProtocol {
    
    static let instance = MockServiceFactory()
    
    var authenticationService: AuthenticationService { LiveAuthenticationService() }
    var tokenService: TokenService { LiveTokenService.shared }
    var accountService: AccountService { MockedAccountService.shared }
    var tournamentService: TournamentService { MockedTournamentService() }
    var bluetoothService: BluetoothService { LiveBluetoothService.shared }
    var credentialService: CredentialService { MockCredentialService.shared }
}
