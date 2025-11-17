//
//  HomeViewController.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("Log in", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        loginBtn.backgroundColor = .randomColor()
        return loginBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 200, height: 200))
            make.center.equalToSuperview()
        }
        
        loginBtn.rx.tap.bind(onNext: { [weak self] in
            self?.popLoginVc()
        }).disposed(by: disposeBag)
    }

}
