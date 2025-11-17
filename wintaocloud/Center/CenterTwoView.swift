//
//  CenterTwoView.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import SnapKit

class CenterTwoView: UIView {

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "center_vip_desc_image")
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "会员中心"
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#7B5522")
        nameLabel.font = UIFont.semiboldFontOfSize(size: 14)
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "开通VIP 享 30+ 项特权"
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.init(hexString: "#7B5522")
        descLabel.font = UIFont.regularFontOfSize(size: 14)
        return descLabel
    }()
    
    lazy var openImageView: UIImageView = {
        let openImageView = UIImageView()
        openImageView.image = UIImage(named: "center_open_vip_image")
        return openImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(openImageView)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 336.pix(), height: 60.pix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11.pix())
            make.left.equalToSuperview().offset(11.pix())
            make.height.equalTo(20.pix())
        }
        descLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10.5.pix())
            make.left.equalToSuperview().offset(11.pix())
            make.height.equalTo(16.5.pix())
        }
        openImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 74.pix(), height: 25.pix()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
