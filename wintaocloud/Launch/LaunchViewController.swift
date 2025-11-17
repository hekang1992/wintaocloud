//
//  LaunchViewController.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import TYAlertController

let CLICK_PRIVACY = "CLICK_PRIVACY"
class LaunchViewController: BaseViewController {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launch_image")
        return bgImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let clickStr = UserDefaults.standard.object(forKey: CLICK_PRIVACY) as? String ?? ""
        if clickStr == "1" {
            NetworkManager.shared.startListening()
        }else {
            self.showAlertPrivacyView()
        }
    }
    
}

extension LaunchViewController {
    
    
    private func showAlertPrivacyView() {
        let popView = PopPrivacyView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)!
        self.present(alertVc, animated: true)
        
        popView.cancelBtn.rx.tap.subscribe(onNext: {
            exit(0)
        }).disposed(by: disposeBag)
        
        popView.sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.savePrivacyInfo()
            NetworkManager.shared.startListening()
        }).disposed(by: disposeBag)
        
        popView.oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let pageUrl = base_url + privacy_url
            self.dismiss(animated: true) {
                self.goWebPageWithUrl(with: pageUrl)
            }
        }).disposed(by: disposeBag)
        
        popView.twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let pageUrl = base_url + agreement_url
            self.dismiss(animated: true) {
                self.goWebPageWithUrl(with: pageUrl)
            }
        }).disposed(by: disposeBag)
    }
}

extension LaunchViewController {
    
    private func savePrivacyInfo() {
        UserDefaults.standard.setValue("1", forKey: CLICK_PRIVACY)
        UserDefaults.standard.synchronize()
    }
    
}
