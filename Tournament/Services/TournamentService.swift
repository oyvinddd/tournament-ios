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
    var tournamentService: TournamentService { LiveServiceFactory.instance.tournamentService }
}

protocol TournamentService {
    
    func updateUsername(_ username: String) async throws -> Account
    
    func getTournament() async throws -> Tournament
    
    func tournamentSearch(query: String) async throws -> [Tournament]
    
    func joinTournament(_ id: UUID, code: String) async throws -> Tournament
    
    func leaveTournament() async throws
    
    func registerWin(opponentId: UUID) async throws
}

final class LiveTournamentService: TournamentService, RequestFactoryInjectable, NetworkManagerInjectable {

    static let shared = LiveTournamentService()
    
    func updateUsername(_ username: String) async throws -> Account {
        let request = requestFactory.updateUsernameRequest(username)
        return try await networkManager.execute(request: request)
    }
    
    func getTournament() async throws -> Tournament {
        let request = requestFactory.getTournamentRequest()
        return try await networkManager.execute(request: request)
    }
    
    func tournamentSearch(query: String) async throws -> [Tournament] {
        let request = requestFactory.tournamentSearchRequest(query: query)
        return try await networkManager.execute(request: request)
    }
    
    func joinTournament(_ id: UUID, code: String) async throws -> Tournament {
        let request = requestFactory.joinTournamentRequest(tournamentId: id, code: code)
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
