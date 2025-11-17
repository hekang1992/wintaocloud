//
//  LoginView.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginView: BaseView {
    
    var backBlock: (() -> Void)?
    
    var sendCodeBlock: (() -> Void)?
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "fork_icon_image"), for: .normal)
        return backBtn
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "login_logo_image")
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = "查风险 用问道云"
        nameLabel.textColor = UIColor.init(hexString: "#666666")
        nameLabel.font = UIFont.regularFontOfSize(size: 14)
        return nameLabel
    }()
    
    lazy var numlabel: UILabel = {
        let numlabel = UILabel()
        numlabel.text = "+86"
        numlabel.textColor = UIColor.init(hexString: "#27344B")
        numlabel.textAlignment = .left
        numlabel.font = .mediumFontOfSize(size: 14)
        return numlabel
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "请输入手机号码", attributes: [
            .foregroundColor: UIColor.init(hexString: "#CECECE") as Any,
            .font: UIFont.regularFontOfSize(size: 16)
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = .regularFontOfSize(size: 16)
        phoneTx.textColor = UIColor.init(hexString: "#27344B")
        phoneTx.becomeFirstResponder()
        phoneTx.addTarget(self, action: #selector(phoneTextDidChange), for: .editingChanged)
        return phoneTx
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .init(hexString: "#EEEEEE")
        return lineView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.setImage(UIImage(named: "login_control_sel"), for: .selected)
        clickBtn.setImage(UIImage(named: "login_control_nor"), for: .normal)
        return clickBtn
    }()
    
    lazy var agreementLabel: UILabel = {
        let fullText = "我已阅读并同意《问道云用户协议》和《问道云隐私政策》"
        let linkText1 = "《问道云用户协议》"
        let linkText2 = "《问道云隐私政策》"
        let attributedString = NSMutableAttributedString(string: fullText)
        let range1 = (fullText as NSString).range(of: linkText1)
        let range2 = (fullText as NSString).range(of: linkText2)
        let linkColor = UIColor.init(hexString: "#547AFF")
        let yinsiLabel = UILabel()
        yinsiLabel.numberOfLines = 0
        yinsiLabel.isUserInteractionEnabled = true
        yinsiLabel.textColor = UIColor.init(hexString: "#9FA4AD")
        yinsiLabel.font = .regularFontOfSize(size: 12)
        attributedString.addAttributes([.foregroundColor: linkColor], range: range1)
        attributedString.addAttributes([.foregroundColor: linkColor], range: range2)
        yinsiLabel.attributedText = attributedString
        return yinsiLabel
    }()
    
    lazy var sendBtn: UIButton = {
        let sendBtn = UIButton(type: .custom)
        sendBtn.setTitle("获取验证码", for: .normal)
        sendBtn.layer.cornerRadius = 4
        sendBtn.isEnabled = false
        sendBtn.backgroundColor = UIColor.init(hexString: "#D0D4DA")
        sendBtn.titleLabel?.font = .regularFontOfSize(size: 18)
        sendBtn.setTitleColor(UIColor.init(hexString: "#FFFFFF"), for: .normal)
        return sendBtn
    }()
    
    lazy var mimaBtn: UIButton = {
        let mimaBtn = UIButton(type: .custom)
        mimaBtn.setTitle("密码登录", for: .normal)
        mimaBtn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
        mimaBtn.titleLabel?.font = .regularFontOfSize(size: 13)
        mimaBtn.backgroundColor = .white
        mimaBtn.layer.masksToBounds = true
        mimaBtn.layer.cornerRadius = 18
        mimaBtn.layer.borderWidth = 1
        mimaBtn.layer.borderColor = UIColor.init(hexString: "#CCCCCC").cgColor
        return mimaBtn
    }()
    
    lazy var weiBtn: UIButton = {
        let weiBtn = UIButton(type: .custom)
        weiBtn.setImage(UIImage(named: "login_wechat_image"), for: .normal)
        weiBtn.adjustsImageWhenHighlighted = false
        return weiBtn
    }()
    
    lazy var footView: LoginFootView = {
        let footView = LoginFootView()
        return footView
    }()
    
    private let isAgreeBinder: BehaviorRelay<Bool> = .init(value: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(backBtn)
        addSubview(logoImageView)
        addSubview(nameLabel)
        addSubview(numlabel)
        addSubview(phoneTx)
        addSubview(lineView)
        addSubview(clickBtn)
        addSubview(agreementLabel)
        addSubview(sendBtn)
        addSubview(footView)
        addSubview(mimaBtn)
        addSubview(weiBtn)
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8.pix())
            make.left.equalToSuperview().offset(9.pix())
            make.size.equalTo(CGSize(width: 24.pix(), height: 24.pix()))
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(backBtn.snp.bottom).offset(23.5.pix())
            make.size.equalTo(CGSize(width: 53.pix(), height: 53.pix()))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(6.pix())
            make.height.equalTo(20.pix())
        }
        
        numlabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(36.5.pix())
            make.left.equalToSuperview().offset(29.5.pix())
            make.height.equalTo(17.pix())
            make.width.equalTo(34.pix())
        }
        phoneTx.snp.makeConstraints { make in
            make.left.equalTo(numlabel.snp.right).offset(12.pix())
            make.centerY.equalTo(numlabel.snp.centerY)
            make.height.equalTo(22.pix())
            make.right.equalToSuperview().offset(-30.pix())
        }
        lineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(numlabel.snp.left)
            make.top.equalTo(phoneTx.snp.bottom).offset(11.pix())
            make.height.equalTo(0.5.pix())
        }
        clickBtn.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(17.5.pix())
            make.left.equalToSuperview().offset(29.pix())
            make.size.equalTo(CGSize(width: 13.pix(), height: 13.pix()))
        }
        agreementLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(15.5.pix())
            make.left.equalTo(clickBtn.snp.right).offset(6.pix())
            make.right.equalToSuperview().offset(-10.pix())
        }
        sendBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(48.pix())
            make.top.equalTo(agreementLabel.snp.bottom).offset(32.5.pix())
            make.left.equalToSuperview().offset(30.pix())
        }
        mimaBtn.snp.makeConstraints { make in
            make.top.equalTo(sendBtn.snp.bottom).offset(32.pix())
            make.left.equalToSuperview().offset(30.pix())
            make.size.equalTo(CGSize(width: 74.pix(), height: 36.pix()))
        }
        weiBtn.snp.makeConstraints { make in
            make.top.equalTo(sendBtn.snp.bottom).offset(32.pix())
            make.right.equalToSuperview().offset(-30.pix())
            make.size.equalTo(CGSize(width: 36.pix(), height: 36.pix()))
        }
        
        footView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(51.5.pix())
        }
        
        backBtn.rx.tap.bind(onNext: { [weak self] in
            self?.backBlock?()
        }).disposed(by: disposeBag)
        
        isAgreeBinder
            .bind(to: clickBtn.rx.isSelected)
            .disposed(by: disposeBag)
        
        clickBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.clickBtn.isSelected.toggle()
            let bool = !isAgreeBinder.value
            if bool {
                self.sendBtn.isEnabled = true
                self.sendBtn.backgroundColor = UIColor.init(hexString: "#547AFF")
            }else {
                self.sendBtn.isEnabled = false
                self.sendBtn.backgroundColor = UIColor.init(hexString: "#D0D4DA")
            }
            isAgreeBinder.accept(bool)
        }).disposed(by: disposeBag)
        
        sendBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.sendCodeBlock?()
        }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView: UITextFieldDelegate {
    
    @objc private func phoneTextDidChange() {
        let filteredText = phoneTx.text?.filter { $0.isNumber } ?? ""
        if filteredText.count > 11 {
            let index = filteredText.index(filteredText.startIndex, offsetBy: 11)
            phoneTx.text = String(filteredText[..<index])
        } else {
            phoneTx.text = filteredText
        }
    }
    
}
