//
//  LoginViewController.swift
//  wintaocloud
//
//  Created by 何康 on 2025/8/1.
//

import UIKit

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
        
        loginView.wechatBtn.isHidden = !WXApi.isWXAppInstalled()
        
        loginView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        loginView.customerBlock = { [weak self] in
            guard let self = self else { return }
            let webVc = WebViewController()
            webVc.pageUrl = base_url + agreement_url
            self.navigationController?.pushViewController(webVc, animated: true)
        }
        
        loginView.agreementBlock = { [weak self] in
            guard let self = self else { return }
            let webVc = WebViewController()
            webVc.pageUrl = base_url + privacy_url
            self.navigationController?.pushViewController(webVc, animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
