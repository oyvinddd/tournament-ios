//
//  JoinTournamentViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

@MainActor final class JoinTournamentViewModel: ObservableObject, TournamentServiceInjectable {
    
    func joinTournament(using code: Int) {
        
        Task {
            
            do {
                try await tournamentService.joinTournament(code: code)
            } catch let error {
                
            }
            
            // if we reach this part, we have joined successfully
        }
    }
}
