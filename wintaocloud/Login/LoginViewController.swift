//
//  LoginViewController.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        loginView.sendCodeBlock = { [weak self] in
            guard let self = self else { return }
            let phoneNumber = self.loginView.phoneTx.text ?? ""
            if phoneNumber.count < 11 {
                ToastViewConfig.showToast(message: "请输入正确的手机号码")
                return
            }
        }
    }
    
}
