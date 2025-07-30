//
//  PopPrivacyView.swift
//  wintaocloud
//
//  Created by 何康 on 2025/7/30.
//

import UIKit

class PopPrivacyView: BaseView {
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.isUserInteractionEnabled = true
        ctImageView.image = UIImage(named: "agreement_image")
        return ctImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        return cancelBtn
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        return sureBtn
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ctImageView)
        ctImageView.addSubview(cancelBtn)
        ctImageView.addSubview(sureBtn)
        ctImageView.addSubview(oneBtn)
        ctImageView.addSubview(twoBtn)
        ctImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 310.pix(), height: 385.pix()))
        }
        cancelBtn.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 155.pix(), height: 60.pix()))
        }
        sureBtn.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 155.pix(), height: 60.pix()))
        }
        oneBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 155.pix(), height: 150.pix()))
        }
        twoBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 155.pix(), height: 150.pix()))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

