//
//  TournamentApp.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI
import Combine

@main struct TournamentApp: App, AccountServiceInjectable {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject private var viewModel = TournamentAppViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            /*
            if viewModel.signedIn {
                HomeView()
            } else {
                BasicSignInView()
            }
             */
            PlayerDetailsView(PlayerDetailsViewModel(Player(id: UUID(), username: "panzertax", score: 1800, matchesPlayed: 0, matchesWon: 0)))
        }
    }
}

@MainActor private final class TournamentAppViewModel: ObservableObject, AccountServiceInjectable {
    
    @Published var signedIn = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        signedIn = accountService.account != nil
        
        accountService.signedIn.receive(on: DispatchQueue.main).sink { [weak self] signedIn in
            self?.signedIn = signedIn
        }.store(in: &subscriptions)
    }
}
