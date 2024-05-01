//
//  ChooseUsernameViewModel.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/04/2024.
//

import Foundation

@MainActor final class ChooseUsernameViewModel: ObservableObject, AccountServiceInjectable {
    
    func chooseUsername(_ username: String) {
        Task {
            do {
                let account = try await accountService.updateUsername(username)
            } catch let error {
                print(error)
            }
        }
    }
}
