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
        changeRootVc()
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = BaseNavigationViewController(rootViewController: LaunchViewController())
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
    
    private func changeRootVc() {
        NotificationCenter.default.addObserver(self, selector: #selector(setUpRootVc(_ :)), name: NSNotification.Name(ROOT_VC), object: nil)
    }
    
    @objc func setUpRootVc(_ notification: Notification) {
        let tabBarVc = BaseTabBarController()
        window?.rootViewController = BaseNavigationViewController(rootViewController: tabBarVc)
    }
    
}
