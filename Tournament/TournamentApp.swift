//
//  TournamentApp.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

@main struct TournamentApp: App, AccountServiceInjectable {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        
        WindowGroup {
            BasicSignInView()
        }
    }
}
