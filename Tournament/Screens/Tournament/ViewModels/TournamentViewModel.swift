//
//  TournamentViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

enum TournamentState {
    
    case idle
    
    case loading
    
    case success(Tournament)
    
    case missingTournament
    
    case failure(Error)
}

@MainActor final class TournamentViewModel: ObservableObject, TournamentServiceInjectable {
    
    @Published var title: String = "Welcome!"
    @Published var state: TournamentState = .loading
    @Published var account: Account?
    
    func getTournament() {
        Task {
            do {
                
                let tournament = try await tournamentService.getTournament()
                title = tournament.title
                state = .success(tournament)
                
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
