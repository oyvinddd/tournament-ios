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

@MainActor final class TournamentViewModel: ObservableObject, AccountServiceInjectable, TournamentServiceInjectable {
    
    @Published var state: TournamentState = .loading
    @Published var account: Account?
    
    init() {
        account = accountService.account
    }
    
    func getTournament() {
        Task {
            do {
                state = .success(try await tournamentService.getTournament())
            } catch let error {
                state = .failure(error)
            }
        }
    }
}
