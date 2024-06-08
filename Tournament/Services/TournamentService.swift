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
    
    func createTournament(_ title: String, resetInterval: ResetInterval) async throws -> Tournament
    
    func tournamentSearch(query: String) async throws -> [Tournament]
    
    func getTournament() async throws -> Tournament
    
    func joinTournament(_ id: UUID, code: String) async throws -> Tournament
    
    func leaveTournament() async throws
    
    func registerWin(opponentId: UUID) async throws
}

final class LiveTournamentService: TournamentService, RequestFactoryInjectable, NetworkManagerInjectable {

    static let shared = LiveTournamentService()
    
    func createTournament(_ title: String, resetInterval: ResetInterval) async throws -> Tournament {
        let request = requestFactory.createTournamentRequest(title, resetInterval: resetInterval)
        return try await networkManager.execute(request: request)
    }
    
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

final class MockedTournamentService: TournamentService, AccountServiceInjectable {
    
    static let shared = MockedTournamentService()
    
    private var tournaments = [
        Tournament(
            id: UUID(),
            adminId: UUID(),
            title: "Tietoevry Bordtennis",
            created: Date.now,
            scoreboard: [
                Player(id: UUID(), username: "oyvind_h", score: 1200, matchesPlayed: 9, matchesWon: 2),
                Player(id: UUID(), username: "panzertax", score: 1600, matchesPlayed: 12, matchesWon: 0),
                Player(id: UUID(), username: "rub1", score: 1300, matchesPlayed: 9, matchesWon: 7),
                Player(id: UUID(), username: "konstant", score: 990, matchesPlayed: 10, matchesWon: 0),
                Player(id: UUID(), username: "stian", score: 120, matchesPlayed: 8, matchesWon: 1),
                Player(id: UUID(), username: "fredrrrik", score: 999, matchesPlayed: 8, matchesWon: 1),
                Player(id: UUID(), username: "n00b", score: 999, matchesPlayed: 8, matchesWon: 100),
                Player(id: UUID(), username: "n00bie", score: 666, matchesPlayed: 80, matchesWon: 101),
                Player(id: UUID(), username: "tor", score: 1200, matchesPlayed: 12, matchesWon: 12),
                Player(id: UUID(), username: "ben", score: 998, matchesPlayed: 0, matchesWon: 0)
            ])
    ]

    func createTournament(_ title: String, resetInterval: ResetInterval) async throws -> Tournament {
        let adminId = accountService.account!.id
        let tournament = Tournament(id: UUID(), adminId: adminId, title: title, created: Date.now, scoreboard: [])
        tournaments.append(tournament)
        return tournaments.last!
    }
    
    func tournamentSearch(query: String) async throws -> [Tournament] {
        return tournaments.filter { tournament in
            tournament.title == query
        }
    }
    
    func getTournament() async throws -> Tournament {
        guard let account = accountService.account else {
            throw APIError.unauthorized
        }
        
        guard let tournamentId = account.tournamentId else {
            throw APIError.missingTournament
        }
        
        for tournament in tournaments {
            if tournament.id == tournamentId {
                return tournament
            }
        }
        
        throw APIError.missingTournament
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
