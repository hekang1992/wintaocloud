//
//  HomeViewController.swift
//  wintaocloud
//
//  Created by 何康 on 2025/7/30.
//

import UIKit

class HomeViewController: BaseViewController {
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.backgroundColor = .random()
        return loginBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.presentLogin()
        }).disposed(by: disposeBag)
        
        
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
