//
//  LoginFootView.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import SnapKit

class LoginFootView: BaseView {

    lazy var diView: UIView = {
        let diView = UIView()
        diView.backgroundColor = UIColor.init(hexString: "#F8F8F8")
        diView.layer.shadowColor = UIColor.init(hexString: "#CDCDCD").cgColor
        diView.layer.shadowOffset = CGSize(width: 0, height: -0.5)
        diView.layer.shadowOpacity = 1
        diView.layer.shadowRadius = 0.5
        return diView
    }()
    
    lazy var dbImageView: UIImageView = {
        let dbImageView = UIImageView()
        dbImageView.image = UIImage(named: "login_logo_image")
        return dbImageView
    }()
    
    lazy var tlabel: UILabel = {
        let tlabel = UILabel()
        tlabel.textAlignment = .left
        tlabel.font = .mediumFontOfSize(size: 11)
        tlabel.textColor = UIColor.init(hexString: "#666666")
        tlabel.numberOfLines = 0
        tlabel.text = "问道云基于公开信息分析生成，仅供参考，并不代表问道云任何暗示之观点或保证。"
        return tlabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(diView)
        diView.addSubview(dbImageView)
        diView.addSubview(tlabel)
        
        diView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dbImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9.5.pix())
            make.left.equalToSuperview().offset(14.pix())
            make.size.equalTo(CGSize(width: 30.pix(), height: 30.pix()))
        }
        tlabel.snp.makeConstraints { make in
            make.centerY.equalTo(dbImageView.snp.centerY)
            make.right.equalToSuperview().offset(-12.pix())
            make.left.equalTo(dbImageView.snp.right).offset(16.5.pix())
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
