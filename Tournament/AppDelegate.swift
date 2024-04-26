//
//  AppDelegate.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        applyGlobalConfiguration()
        return true
    }
    
    private func applyGlobalConfiguration() {
        //UIScrollView.appearance().bounces = false
        UIScrollView.appearance().isPagingEnabled = true
        UIScrollView.appearance().showsHorizontalScrollIndicator = false
        UIScrollView.appearance().showsVerticalScrollIndicator = false
    }
}
