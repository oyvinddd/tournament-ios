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
    
    func joinTournament(code: String) async throws
    
    func leaveTournament() async throws
}

final class MockedTournamentService: TournamentService, DataFactoryInjectable {

    func getTournament() async throws -> Tournament {
        return dataFactory.tournament
    }
    
    func joinTournament(code: String) async throws {
    }
    
    func leaveTournament() async throws {
    }
}
