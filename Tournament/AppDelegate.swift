//
//  AppDelegate.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate, AccountServiceInjectable {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        applyGlobalConfiguration()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        tryRegisteringPushToken(deviceToken)
    }
    
    private func applyGlobalConfiguration() {
        // scroll view
        UIScrollView.appearance().isPagingEnabled = true
        UIScrollView.appearance().showsHorizontalScrollIndicator = false
        UIScrollView.appearance().showsVerticalScrollIndicator = false
        // text field
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    private func tryRegisteringPushToken(_ tokenData: Data) {
        Task {
            do {
                try await accountService.registerPushToken(tokenData)
            } catch let error {
                // we just fail silently, since the user does not need to know about this
                print("Error registering push token: \(error.localizedDescription)")
            }
        }
    }
}
