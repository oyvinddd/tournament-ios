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

// MARK: - Live tournament service

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

// MARK: - Mocked tournament service

final class MockedTournamentService: TournamentService, AccountServiceInjectable {
    
    static let shared = MockedTournamentService()
    
    private var tournaments = [
        Tournament(
            id: UUID(uuidString: "9e061887-ab41-47fa-af58-107b561d67ab")!,
            adminId: UUID(),
            title: "Tietoevry Bordtennis",
            isActive: true,
            tournamentAccounts: []
        )
    ]
    
    func createTournament(_ title: String, resetInterval: ResetInterval) async throws -> Tournament {
        
        let account = accountService.account!
        let player = Player(
            id: account.id,
            tournamentId: UUID(),
            accountId: UUID(),
            username: account.userName,
            score: 1600,
            matchesWon: 0,
            matchesPlayed: 0
        )
        
        let tournament = Tournament(id: UUID(), adminId: account.id, title: title, isActive: true, tournamentAccounts: [player])
        tournaments.append(tournament)
        return tournaments.last!
    }
    
    func tournamentSearch(query: String) async throws -> [Tournament] {
        return tournaments.filter { $0.title.lowercased().contains(query) }
    }
    
    func getTournament() async throws -> Tournament {
        guard let account = accountService.account else {
            throw APIError.unauthorized
        }
        /*
        guard let tournamentId = account.tournamentId else {
            throw APIError.missingTournament
        }
        
        for tournament in tournaments {
            if tournament.id == tournamentId {
                return tournament
            }
        }
        */
        throw APIError.missingTournament
    }
    
    func joinTournament(_ id: UUID, code: String) async throws -> Tournament {
        return Tournament(id: id, adminId: UUID(), title: "Foo Bar", isActive: true, tournamentAccounts: [])
    }
    
    func leaveTournament() async throws {
    }
    
    func registerWin(opponentId: UUID) async throws {
    }
}
