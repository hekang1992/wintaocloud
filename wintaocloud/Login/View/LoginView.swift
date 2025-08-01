//
//  LoginView.swift
//  wintaocloud
//
//  Created by 何康 on 2025/8/1.
//

import UIKit
import RxGesture

class LoginView: BaseView {
    
    var backBlock: (() -> Void)?
    var customerBlock: (() -> Void)?
    var agreementBlock: (() -> Void)?
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "login_cancel_image"), for: .normal)
        return cancelBtn
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "login_logo_image")
        ctImageView.contentMode = .scaleAspectFit
        return ctImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "查风险 用问道云"
        descLabel.textColor = UIColor.init(cssStr: "#666666")
        descLabel.textAlignment = .center
        descLabel.font = UIFont.regularFontOfSize(size: 14.pix())
        return descLabel
    }()
    
    lazy var numlabel: UILabel = {
        let numlabel = UILabel()
        numlabel.text = "+86"
        numlabel.textColor = UIColor.init(cssStr: "#27344B")
        numlabel.textAlignment = .left
        numlabel.font = .mediumFontOfSize(size: 14)
        return numlabel
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "请输入手机号码", attributes: [
            .foregroundColor: UIColor.init(cssStr: "#CECECE") as Any,
            .font: UIFont.regularFontOfSize(size: 16)
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = .regularFontOfSize(size: 16)
        phoneTx.textColor = UIColor.init(cssStr: "#27344B")
        return phoneTx
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .init(cssStr: "#EEEEEE")
        return lineView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.setImage(UIImage(named: "pri_image_sel"), for: .selected)
        clickBtn.setImage(UIImage(named: "pri_image_nor"), for: .normal)
        return clickBtn
    }()
    
    lazy var agreementLabel: UILabel = {
        let fullText = "我已阅读并同意《问道云用户协议》和《问道云隐私政策》"
        let linkText1 = "《问道云用户协议》"
        let linkText2 = "《问道云隐私政策》"
        let attributedString = NSMutableAttributedString(string: fullText)
        let range1 = (fullText as NSString).range(of: linkText1)
        let range2 = (fullText as NSString).range(of: linkText2)
        let linkColor = UIColor.init(cssStr: "#547AFF")
        let agreementLabel = UILabel()
        agreementLabel.numberOfLines = 0
        agreementLabel.isUserInteractionEnabled = true
        agreementLabel.textColor = UIColor.init(cssStr: "#9FA4AD")
        agreementLabel.font = .regularFontOfSize(size: 12)
        attributedString.addAttributes([.foregroundColor: linkColor!], range: range1)
        attributedString.addAttributes([.foregroundColor: linkColor!], range: range2)
        agreementLabel.attributedText = attributedString
        return agreementLabel
    }()
    
    lazy var sendBtn: UIButton = {
        let sendBtn = UIButton(type: .custom)
        sendBtn.setTitle("获取验证码", for: .normal)
        sendBtn.layer.cornerRadius = 4
        sendBtn.isEnabled = false
        sendBtn.backgroundColor = UIColor.init(cssStr: "#D0D4DA")
        sendBtn.titleLabel?.font = .regularFontOfSize(size: 18)
        sendBtn.setTitleColor(UIColor.init(cssStr: "#FFFFFF"), for: .normal)
        return sendBtn
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setTitle("一键登录", for: .normal)
        oneBtn.setTitleColor(UIColor.init(cssStr: "#333333"), for: .normal)
        oneBtn.titleLabel?.font = .regularFontOfSize(size: 13)
        oneBtn.backgroundColor = .white
        oneBtn.layer.cornerRadius = 18
        oneBtn.layer.borderWidth = 1
        oneBtn.layer.masksToBounds = true
        oneBtn.layer.borderColor = UIColor.init(cssStr: "#CCCCCC")?.cgColor
        return oneBtn
    }()
    
    lazy var mimaBtn: UIButton = {
        let mimaBtn = UIButton(type: .custom)
        mimaBtn.setTitle("密码登录", for: .normal)
        mimaBtn.setTitleColor(UIColor.init(cssStr: "#333333"), for: .normal)
        mimaBtn.titleLabel?.font = .regularFontOfSize(size: 13)
        mimaBtn.backgroundColor = .white
        mimaBtn.layer.masksToBounds = true
        mimaBtn.layer.cornerRadius = 18
        mimaBtn.layer.borderWidth = 1
        mimaBtn.layer.borderColor = UIColor.init(cssStr: "#CCCCCC")?.cgColor
        return mimaBtn
    }()
    
    lazy var wechatBtn: UIButton = {
        let wechatBtn = UIButton(type: .custom)
        wechatBtn.setImage(UIImage(named: "wechat_login_image"), for: .normal)
        wechatBtn.adjustsImageWhenHighlighted = false
        return wechatBtn
    }()
    
    lazy var footView: LoginFooterView = {
        let footView = LoginFooterView()
        return footView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cancelBtn)
        addSubview(ctImageView)
        addSubview(descLabel)
        addSubview(numlabel)
        addSubview(phoneTx)
        addSubview(lineView)
        addSubview(clickBtn)
        addSubview(agreementLabel)
        addSubview(sendBtn)
        addSubview(oneBtn)
        addSubview(mimaBtn)
        addSubview(wechatBtn)
        addSubview(footView)
        
        cancelBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 24.pix(), height: 24.pix()))
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10.pix())
            make.left.equalToSuperview().offset(9.pix())
        }
        ctImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 53.pix(), height: 53.pix()))
            make.top.equalTo(cancelBtn.snp.bottom).offset(23.pix())
        }
        
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ctImageView.snp.bottom).offset(6.pix())
            make.height.equalTo(20.pix())
        }
        
        numlabel.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(36.pix())
            make.left.equalToSuperview().offset(29.pix())
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
            make.height.equalTo(1.pix())
        }
        clickBtn.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(17.pix())
            make.left.equalToSuperview().offset(29.pix())
            make.size.equalTo(CGSize(width: 13.pix(), height: 13.pix()))
        }
        agreementLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(15.pix())
            make.left.equalTo(clickBtn.snp.right).offset(6.pix())
            make.right.equalToSuperview().offset(-20.pix())
        }
        sendBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(48.pix())
            make.top.equalTo(agreementLabel.snp.bottom).offset(32.pix())
            make.left.equalToSuperview().offset(30.pix())
        }
        oneBtn.snp.makeConstraints { make in
            make.top.equalTo(sendBtn.snp.bottom).offset(32.pix())
            make.left.equalToSuperview().offset(30.pix())
            make.size.equalTo(CGSize(width: 74.pix(), height: 36.pix()))
        }
        mimaBtn.snp.makeConstraints { make in
            make.top.equalTo(sendBtn.snp.bottom).offset(32.pix())
            make.left.equalTo(oneBtn.snp.right).offset(12.pix())
            make.size.equalTo(CGSize(width: 74.pix(), height: 36.pix()))
        }
        wechatBtn.snp.makeConstraints { make in
            make.centerY.equalTo(mimaBtn.snp.centerY)
            make.right.equalToSuperview().offset(-30.pix())
            make.size.equalTo(CGSize(width: 36.pix(), height: 36.pix()))
        }
        footView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(51.pix())
        }
        
        cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.backBlock?()
        }).disposed(by: disposeBag)
        
        clickBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.clickBtn.isSelected.toggle()
        }).disposed(by: disposeBag)
        
        agreementLabel
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] gesture in
                guard let self = self else { return }
                let text = agreementLabel.text ?? ""
                let range1 = (text as NSString).range(of: "《问道云用户协议》")
                let range2 = (text as NSString).range(of: "《问道云隐私政策》")
                if gesture.didTapAttributedTextInLabel(label: agreementLabel, inRange: range1) {
                    self.customerBlock?()
                } else if gesture.didTapAttributedTextInLabel(label: agreementLabel, inRange: range2) {
                    self.agreementBlock?()
                }
            }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attributedText = label.attributedText else { return false }
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        let location = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let offset = CGPoint(
            x: (label.bounds.size.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
            y: (label.bounds.size.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
        )
        let adjustedLocation = CGPoint(x: location.x - offset.x, y: location.y - offset.y)
        
        let index = layoutManager.characterIndex(for: adjustedLocation, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(index, targetRange)
    }
}
