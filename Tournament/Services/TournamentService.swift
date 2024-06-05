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
    
    func tournamentSearch(query: String) async throws -> [Tournament]
    
    func getTournament() async throws -> Tournament
    
    func joinTournament(_ id: UUID, code: String) async throws -> Tournament
    
    func leaveTournament() async throws
    
    func registerWin(opponentId: UUID) async throws
}

final class LiveTournamentService: TournamentService, RequestFactoryInjectable, NetworkManagerInjectable {

    static let shared = LiveTournamentService()
    
    func tournamentSearch(query: String) async throws -> [Tournament] {
        let request = requestFactory.tournamentSearchRequest(query: query)
        return try await networkManager.execute(request: request)
    }
    
    func getTournament() async throws -> Tournament {
        let request = requestFactory.getTournamentRequest()
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

final class MockedTournamentService: TournamentService {
    
    func tournamentSearch(query: String) async throws -> [Tournament] {
        return []
    }
    
    func getTournament() async throws -> Tournament {
        
        let random = 0//Int.random(in: 0...2)
        
        if random == 0 {
            let scoreboard: [Player] = [
                Player(id: UUID(), username: "oyvind_h", score: 1200, matchesPlayed: 9, matchesWon: 2),
                Player(id: UUID(), username: "panzertax", score: 1600, matchesPlayed: 12, matchesWon: 0),
                Player(id: UUID(), username: "rub1", score: 1300, matchesPlayed: 9, matchesWon: 7),
                Player(id: UUID(), username: "konstant", score: 990, matchesPlayed: 10, matchesWon: 0),
                Player(id: UUID(), username: "stian", score: 120, matchesPlayed: 8, matchesWon: 1)
            ]
            return Tournament(
                id: UUID(),
                adminId: UUID(),
                title: "Foo Tournament",
                created: Date.now,
                scoreboard: scoreboard
            )
        } else if random == 1 {
            throw APIError.missingTournament
        } else {
            throw APIError.invalidResponse
        }
    }
    
    func joinTournament(_ id: UUID, code: String) async throws -> Tournament {
        return Tournament(
            id: UUID(),
            adminId: UUID(),
            title: "Foo Tournament",
            created: Date.now,
            scoreboard: []
        )
    }
    
    func leaveTournament() async throws {
    }
    
    func registerWin(opponentId: UUID) async throws {
    }
}
