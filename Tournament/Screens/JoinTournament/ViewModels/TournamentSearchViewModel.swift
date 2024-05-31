//
//  TournamentSearchViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 31/05/2024.
//

import Foundation

enum TournamentSearchState {
    case idle
    case failure(Error)
    case success([Tournament])
}

@MainActor final class TournamentSearchViewModel: ObservableObject, TournamentServiceInjectable {
    
    @Published var state: TournamentSearchState = .idle
    
    func tournamentSearch(query: String) {
        Task {
            do {
                let tournaments = try await tournamentService.tournamentSearch(query: query)
                state = .success(tournaments)
            } catch let error {
                state = .failure(error)
            }
        }
    }
}
