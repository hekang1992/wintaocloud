//
//  AppDelegate.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initNoti()
        initKeybord()
        initWindow()
        return true
    }


}

extension AppDelegate {
    
    private func initNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(setUpRootVc(_ :)), name: NSNotification.Name(ROOT_VC), object: nil)
    }
    
    private func initKeybord() {
        let manager = IQKeyboardManager.shared
        manager.enable = true
        manager.shouldResignOnTouchOutside = true
    }
    
    private func initWindow() {
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = BaseNavigationController(rootViewController: LaunchViewController())
        window?.makeKeyAndVisible()
    }
    
    @objc func setUpRootVc(_ noti: Notification) {
        let tabBarVc = BaseTabBarController()
        self.window?.rootViewController = BaseNavigationController(rootViewController: tabBarVc)
    }
}
