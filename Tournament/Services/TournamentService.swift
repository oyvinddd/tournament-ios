//
//  TournamentService.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

protocol TournamentServiceInjectable {
    var tournamentService: TournamentService { get }
}

extension TournamentServiceInjectable {
    var tournamentService: TournamentService { MockServiceFactory.instance.tournamentService }
}

protocol TournamentService {
    
    func getTournament() async throws -> Tournament
    
    func joinTournament(code: String) async throws -> Tournament
    
    func leaveTournament() async throws
    
    func registerWin(opponentId: UUID) async throws
}

// MARK: - Live service

final class LiveTournamentService: TournamentService, RequestFactoryInjectable, NetworkManagerInjectable {
    
    func getTournament() async throws -> Tournament {
        let request = requestFactory.getTournamentRequest()
        return try await networkManager.execute(request: request)
    }
    
    func joinTournament(code: String) async throws -> Tournament {
        let request = requestFactory.joinTournamentRequest(code: code)
        return try await networkManager.execute(request: request)
    }
    
    func leaveTournament() async throws {
        let request = requestFactory.leaveTournamentRequest()
        return try await networkManager.execute(request: request)
    }
    
    func registerWin(opponentId: UUID) async throws {
        let request = requestFactory.registerWinRequest(opponentId: opponentId)
        return try await networkManager.execute(request: request)
    }
}

// MARK: - Mocked service

final class MockedTournamentService: TournamentService, AccountServiceInjectable, DataFactoryInjectable {

    func getTournament() async throws -> Tournament {
        /*
        guard accountService.account?.hasTournament ?? false else {
            throw APIError.noTournament
        }
         */
        return dataFactory.tournament
    }
    
    func joinTournament(code: String) async throws -> Tournament {
        let tournament = dataFactory.tournament
        //accountService.account?.tournamentId = tournament.id
        return tournament
    }
    
    func leaveTournament() async throws {
    }
    
    func registerWin(opponentId: UUID) async throws {
    }
}
