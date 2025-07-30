//
//  BaseTabBarController.swift
//  wintaocloud
//
//  Created by 何康 on 2025/7/30.
//

import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 10
        let homeVC = HomeViewController()
        let riskVc = RiskControlViewController()
        var diligenceVc = DiligenceViewController()
        let centerVC = CenterViewController()
        
        homeVC.tabBarItem = UITabBarItem(
            title: "首页",
            image: UIImage(named: "home_nor")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "home_sel")?.withRenderingMode(.alwaysOriginal)
        )
        
        riskVc.tabBarItem = UITabBarItem(
            title: "风控",
            image: UIImage(named: "risk_nor")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "risk_sel")?.withRenderingMode(.alwaysOriginal)
        )
        
        diligenceVc.tabBarItem = UITabBarItem(
            title: "尽调",
            image: UIImage(named: "dili_nor")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "dili_sel")?.withRenderingMode(.alwaysOriginal)
        )
        
        centerVC.tabBarItem = UITabBarItem(
            title: "我的",
            image: UIImage(named: "center_nor")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "center_sel")?.withRenderingMode(.alwaysOriginal)
        )
        
        viewControllers = [
            BaseNavigationViewController(rootViewController: homeVC),
            BaseNavigationViewController(rootViewController: riskVc),
            BaseNavigationViewController(rootViewController: diligenceVc),
            BaseNavigationViewController(rootViewController: centerVC)
        ]
        
        // 设置字体样式
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.mediumFontOfSize(size: 12),
            .foregroundColor: UIColor.init(cssStr: "#9FA4AD")!
        ]
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.mediumFontOfSize(size: 12),
            .foregroundColor: UIColor.init(cssStr: "#27344B")!
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        HapticFeedbackManager.triggerImpactFeedback(style: .medium)
        guard let selectedItem = tabBarController.tabBar.selectedItem else { return }
        if let selectedView = selectedItem.value(forKey: "view") as? UIView {
            if let imageView = selectedView.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                let scaleUp = CABasicAnimation(keyPath: "transform.scale")
                scaleUp.fromValue = 1.0
                scaleUp.toValue = 1.1
                scaleUp.duration = 0.1
                scaleUp.autoreverses = true
                scaleUp.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                imageView.layer.add(scaleUp, forKey: nil)
            }
        }
    }
    
}
