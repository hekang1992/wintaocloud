//
//  LoginFooterView.swift
//  wintaocloud
//
//  Created by 何康 on 2025/8/1.
//

import UIKit

class LoginFooterView: BaseView {

    lazy var diView: UIView = {
        let diView = UIView()
        diView.backgroundColor = UIColor.init(cssStr: "#F8F8F8")
        diView.layer.shadowColor = UIColor.init(cssStr: "#CDCDCD")?.cgColor
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
        tlabel.font = .mediumFontOfSize(size: 10)
        tlabel.textColor = UIColor.init(cssStr: "#666666")
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
            make.top.equalToSuperview().offset(9.5)
            make.left.equalToSuperview().offset(14)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        tlabel.snp.makeConstraints { make in
            make.centerY.equalTo(dbImageView.snp.centerY)
            make.right.equalToSuperview().offset(-12)
            make.left.equalTo(dbImageView.snp.right).offset(16.5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
