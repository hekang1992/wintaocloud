//
//  LoginCodeView.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import KeenCodeUnit
import SnapKit

class LoginCodeView: BaseView {
    
    var codeBlock: ((String) -> Void)?
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "fork_icon_image"), for: .normal)
        return backBtn
    }()
    
    lazy var label1: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .mediumFontOfSize(size: 24)
        label.textColor = UIColor.init(hexString: "#27344C")
        label.text = "输入短信验证码"
        return label
    }()
    
    lazy var pLabel: UILabel = {
        let pLabel = UILabel()
        pLabel.textAlignment = .left
        pLabel.textColor = UIColor.init(hexString: "#9FA4AD")
        return pLabel
    }()
    
    lazy var resendBtn: UIButton = {
        let resendBtn = UIButton(type: .custom)
        resendBtn.setTitleColor(UIColor.init(hexString: "#BDBDBD"), for: .normal)
        resendBtn.titleLabel?.font = .regularFontOfSize(size: 14)
        return resendBtn
    }()
    
    private var codeUnit: KeenCodeUnit!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(backBtn)
        addSubview(label1)
        addSubview(pLabel)
        addSubview(resendBtn)
        
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8.pix())
            make.left.equalToSuperview().offset(8.5.pix())
            make.size.equalTo(CGSize(width: 24.pix(), height: 24.pix()))
        }
        label1.snp.makeConstraints { make in
            make.height.equalTo(29.pix())
            make.top.equalTo(backBtn.snp.bottom).offset(42.pix())
            make.left.equalToSuperview().offset(30.pix())
        }
        pLabel.snp.makeConstraints { make in
            make.left.equalTo(label1.snp.left)
            make.top.equalTo(label1.snp.bottom).offset(12.pix())
            make.height.equalTo(17.pix())
        }
        
        resendBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(codeUnit.snp.bottom).offset(48.pix())
            make.size.equalTo(CGSize(width: 115.pix(), height: 17.pix()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginCodeView: KeenCodeUnitDelegate {
    
    func attributesOfCodeUnit(for codeUnit: KeenCodeUnit) -> KeenCodeUnitAttributes {
        var attr = KeenCodeUnitAttributes()
        attr.style = .splitborder
        attr.textFont = .mediumFontOfSize(size: 50)
        attr.isSingleAlive = true
        attr.borderRadius = 5
        attr.viewBackColor = .clear
        return attr
    }
    
    func codeUnit(_ codeUnit: KeenCodeUnit, codeText: String, complete: Bool) {
        if complete {
            print("codeText====\(codeText)")
            self.codeBlock?(codeText)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let pLabelY = self.pLabel.frame.maxY
        let rect = CGRect(x: 20, y: pLabelY + 50.pix(), width: CGFloat.screenWidth - 40, height: 66.pix())
        codeUnit = KeenCodeUnit(
            frame: rect,
            delegate: self
        ).addViewTo(self)
    }
    
}
