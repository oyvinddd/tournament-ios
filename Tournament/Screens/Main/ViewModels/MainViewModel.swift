//
//  MainViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

@MainActor final class MainViewModel: ObservableObject, AccountServiceInjectable {
    
    @Published var showSignIn = false
    
    init() {
        showSignIn = !accountService.authenticated
    }
}
