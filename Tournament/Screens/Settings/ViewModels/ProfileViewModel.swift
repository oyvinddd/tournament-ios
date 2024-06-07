//
//  ProfileViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import Foundation

@MainActor final class ProfileViewModel: ObservableObject, AccountServiceInjectable {
    
    var account: Account? { accountService.account }
    
    func signOut() {
        accountService.signOut()
    }
}
