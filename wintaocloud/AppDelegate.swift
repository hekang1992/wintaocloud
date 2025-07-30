//
//  AppDelegate.swift
//  wintaocloud
//
//  Created by 何康 on 2025/7/30.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        keyBordManager()
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = LaunchViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

extension AppDelegate {
    
    private func keyBordManager() {
        let manager = IQKeyboardManager.shared
        manager.enable = true
        manager.shouldResignOnTouchOutside = true
    }
    
}
