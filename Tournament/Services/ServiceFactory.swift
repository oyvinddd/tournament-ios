//
//  ServiceFactory.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

protocol ServiceFactoryProtocol {
    
    var accountService: AccountService { get }
    var tournamentService: TournamentService { get }
}

final class MockServiceFactory: ServiceFactoryProtocol {
    
    static let instance = MockServiceFactory()
    
    var accountService: AccountService { MockedAccountService.shared }
    var tournamentService: TournamentService { MockedTournamentService() }
}
