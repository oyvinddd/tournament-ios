//
//  CreateTournamentViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 07/06/2024.
//

import Foundation

enum CreateTournamentState {
    case idle, loading, success(Tournament), failure(Error)
}

@MainActor final class CreateTournamentViewModel: ObservableObject, TournamentServiceInjectable {
    
    @Published var state: CreateTournamentState = .idle
    
    func createTournament(title: String, resetInterval: ResetInterval = .never) {
        state = .loading
        
        Task {
            do {
                let tournament = try await tournamentService.createTournament(title, resetInterval: resetInterval)
                state = .success(tournament)
                
            } catch let error {
                state = .failure(error)
            }
        }
    }
}
