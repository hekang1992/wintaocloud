//
//  LaunchViewController.swift
//  wintaocloud
//
//  Created by 何康 on 2025/7/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import TYAlertController

let CLICK_PRIVACY = "CLICK_PRIVACY"

class LaunchViewController: BaseViewController {
    
    lazy var homeBgImageView: UIImageView = {
        let homeBgImageView = UIImageView()
        homeBgImageView.image = UIImage(named: "launch")
        homeBgImageView.contentMode = .scaleAspectFill
        return homeBgImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeBgImageView)
        homeBgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let clickStr = UserDefaults.standard.object(forKey: CLICK_PRIVACY) as? String ?? ""
        if clickStr == "1" {
            NetworkManager.shared.startListening()
        }else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.showAlertPrivacyView()
            }
        }
    }
    
}

extension LaunchViewController {
    
    private func showAlertPrivacyView() {
        let popView = PopPrivacyView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 400.pix()))
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
            self.dismiss(animated: true) {
                let pageUrl = base_url + privacy_url
                let webVc = WebViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }
        }).disposed(by: disposeBag)
        
        popView.twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                let pageUrl = base_url + agreement_url
                let webVc = WebViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }
        }).disposed(by: disposeBag)
        
    }
    
    private func savePrivacyInfo() {
        UserDefaults.standard.setValue("1", forKey: CLICK_PRIVACY)
        UserDefaults.standard.synchronize()
    }
    
}
