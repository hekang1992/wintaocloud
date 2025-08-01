//
//  BaseViewController.swift
//  wintaocloud
//
//  Created by 何康 on 2025/7/30.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        return headView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }

}

extension BaseViewController {
    
    //登录弹窗
    func presentLogin() {
        WDLoginConfig.removeLoginInfo()
        let loginVc = LoginViewController()
        let rootVc = BaseNavigationViewController(rootViewController: loginVc)
        rootVc.modalPresentationStyle = .overFullScreen
        self.present(rootVc, animated: true)
    }
    
}
