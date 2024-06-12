//
//  TournamentViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation
import Combine

enum TournamentState {
    
    case idle
    
    case loading
    
    case success(Tournament)
    
    case missingTournament
    
    case failure(Error)
}

@MainActor final class TournamentViewModel: ObservableObject, AccountServiceInjectable, TournamentServiceInjectable, PlayerBroadcastServiceInjectable {
    
    @Published var title: String = "Welcome!"
    @Published var state: TournamentState = .loading
    @Published var account: Account?
    @Published var broadcasting: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        account = accountService.account
        
        accountService.joinedTournament.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.getTournament()
        }.store(in: &subscriptions)
    }
    
    func getTournament() {
        state = .loading
        
        Task {
            do {
                
                let tournament = try await tournamentService.getTournament()
                title = tournament.title
                state = .success(tournament)
                
            } catch let error {
                
                guard (error as? APIError) != APIError.missingTournament else {
                    state = .missingTournament
                    return
                }
                
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
    
    func startBluetoothBroadcasting() {
        playerBroadcastService.toggleBroadcasting(true)
    }
    
    func stopBluetoothBroadcasting() {
        playerBroadcastService.toggleBroadcasting(false)
    }
}
