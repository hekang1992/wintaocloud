//
//  CenterThreeView.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import SnapKit

class CenterThreeView: UIView {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 5.pix()
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "center_three_list_image")
        return bgImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 115.5.pix()))
        }
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
