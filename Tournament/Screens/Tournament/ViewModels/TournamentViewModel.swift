//
//  TournamentViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

@MainActor final class TournamentViewModel: ObservableObject, TournamentServiceInjectable {
    
    @Published var tournament: Tournament?
    
    func getTournament() {
        Task {
            do {
                tournament = try await tournamentService.getTournament()
            } catch let error {
                print(error)
            }
        }
    }
}
