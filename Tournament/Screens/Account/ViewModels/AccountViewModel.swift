//
//  AccountViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import Foundation

@MainActor final class AccountViewModel: ObservableObject, AccountServiceInjectable {
    
    var account: Account? { accountService.account }
    
    var information: String {
        guard let tid = account?.tournamentAccounts?.first?.id else {
            return "No tournament"
        }
        return tid.uuidString
    }
    
    func signOut() {
        accountService.signOut()
    }
}
