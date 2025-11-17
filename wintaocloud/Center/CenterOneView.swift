//
//  CenterOneView.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import SnapKit

class CenterOneView: BaseView {

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.regularFontOfSize(size: 12)
        return nameLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(bgImageView)
        addSubview(nameLabel)
        
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(14.5.pix())
            make.size.equalTo(CGSize(width: 26.pix(), height: 26.pix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgImageView.snp.bottom).offset(6.pix())
            make.height.equalTo(16.5.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
