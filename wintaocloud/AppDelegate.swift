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
        manager()
        changeRootVc()
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = BaseNavigationViewController(rootViewController: LaunchViewController())
        window?.makeKeyAndVisible()
        return true
    }

}

extension AppDelegate {
    
    private func manager() {
        //键盘
        let manager = IQKeyboardManager.shared
        manager.enable = true
        manager.shouldResignOnTouchOutside = true
        
        //微信
        WXApi.registerApp("wx24b1a40f5ff2811e", universalLink: "https://h5.wintaocloud.com/iOS/")
        
    }
    
    private func changeRootVc() {
        NotificationCenter.default.addObserver(self, selector: #selector(setUpRootVc(_ :)), name: NSNotification.Name(ROOT_VC), object: nil)
    }
    
    @objc func setUpRootVc(_ notification: Notification) {
        let tabBarVc = BaseTabBarController()
        window?.rootViewController = BaseNavigationViewController(rootViewController: tabBarVc)
    }
    
}

extension AppDelegate: WXApiDelegate {
    
    // 兼容旧版 iOS
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }

    // 现代 iOS 系统推荐
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func onResp(_ resp: BaseResp) {
        if let authResp = resp as? SendAuthResp, authResp.errCode == 0 {
            // 登录成功，拿到授权码 code
            let code = authResp.code
            print("微信登录成功，授权码：\(code ?? "")")
        } else {
            // 登录失败或用户取消
            print("微信登录失败或取消，错误码：\(resp.errCode)")
        }
    }
    
}
