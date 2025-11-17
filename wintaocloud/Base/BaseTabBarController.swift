//
//  BaseTabBarController.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.init(hexString: "#27344B"),
            .font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight(500))
        ]
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.init(hexString: "#9FA4AD"),
            .font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight(500))
        ]
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        let bgView = UIView(frame: tabBar.bounds)
        bgView.backgroundColor = UIColor.clear
        bgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.insertSubview(bgView, at: 0)
        
    }
    
    private func setupViewControllers() {
        let firstVC = createNavController(
            title: "首页",
            image: UIImage(named: "home_nor") ?? UIImage(),
            selectedImage: UIImage(named: "home_sel") ?? UIImage(),
            rootViewController: HomeViewController()
        )
        
        let secondVC = createNavController(
            title: "风控",
            image: UIImage(named: "risk_nor") ?? UIImage(),
            selectedImage: UIImage(named: "risk_sel") ?? UIImage(),
            rootViewController: RiskControlViewController()
        )
        
        let thirdVC = createNavController(
            title: "尽调",
            image: UIImage(named: "dili_nor") ?? UIImage(),
            selectedImage: UIImage(named: "dili_sel") ?? UIImage(),
            rootViewController: DueViewController()
        )
        
        let fourVC = createNavController(
            title: "我的",
            image: UIImage(named: "center_nor") ?? UIImage(),
            selectedImage: UIImage(named: "center_sel") ?? UIImage(),
            rootViewController: CenterViewController()
        )
        
        viewControllers = [firstVC, secondVC, thirdVC, fourVC]
        
        selectedIndex = 0
    }
    
    private func createNavController(title: String, image: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> BaseNavigationController {
        let navController = BaseNavigationController(rootViewController: rootViewController)
        
        navController.tabBarItem = UITabBarItem(
            title: title,
            image: image.withRenderingMode(.alwaysOriginal),
            selectedImage: selectedImage.withRenderingMode(.alwaysOriginal)
        )
        
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        return navController
    }
}
