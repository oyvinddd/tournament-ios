//
//  PlayerDetailsViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 07/06/2024.
//

import Foundation

@MainActor final class PlayerDetailsViewModel: ObservableObject, TournamentServiceInjectable {
    
    let player: Player
    
    init(_ player: Player) {
        self.player = player
    }
}
