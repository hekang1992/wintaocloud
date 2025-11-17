//
//  CenterFourView.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import SnapKit

class CenterFourView: UIView {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 5.pix()
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = "更多功能"
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.mediumFontOfSize(size: 14)
        return nameLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 234.5.pix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7.5.pix())
            make.left.equalToSuperview().offset(15.5.pix())
            make.height.equalTo(20.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
