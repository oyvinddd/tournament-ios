//
//  TournamentViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

enum TournamentState {
    
    case loading
    
    case success(Tournament)
    
    case failure(Error)
}

@MainActor final class TournamentViewModel: ObservableObject, TournamentServiceInjectable {
    
    @Published var state: TournamentState = .loading
    @Published var account: Account?
    
    func getTournament() {
        Task {
            do {
                state = .success(try await tournamentService.getTournament())
            } catch let error {
                state = .failure(error)
            }
        }
    }
    
    func leaveTournament() {
        Task {
            
            do {
                
                try await tournamentService.leaveTournament()
                
            } catch let error {
                print(error)
            }
            
            // if we reach this part we have successfully left
        }
    }
}
