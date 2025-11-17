//
//  CenterView.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import SnapKit

class CenterView: BaseView {

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "center_head_image")
        return bgImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "center_icon_image")
        return iconImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textAlignment = .left
        phoneLabel.text = "135****12"
        phoneLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        phoneLabel.font = UIFont.mediumFontOfSize(size: 20)
        return phoneLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.text = "问道云已陪伴您 1 天"
        descLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        descLabel.font = UIFont.regularFontOfSize(size: 12)
        return descLabel
    }()
    
    lazy var vipImageView: UIImageView = {
        let vipImageView = UIImageView()
        vipImageView.image = UIImage(named: "center_normal_vip_image")
        vipImageView.contentMode = .scaleAspectFit
        return vipImageView
    }()
    
    lazy var settingBtn: UIButton = {
        let settingBtn = UIButton(type: .custom)
        settingBtn.setBackgroundImage(UIImage(named: "center_setting_image"), for: .normal)
        return settingBtn
    }()
    
    lazy var oneBgView: UIView = {
        let oneBgView = UIView()
        oneBgView.layer.cornerRadius = 5.pix()
        oneBgView.layer.masksToBounds = true
        oneBgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return oneBgView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var oneListView: CenterOneView = {
        let oneListView = CenterOneView()
        oneListView.bgImageView.image = UIImage(named: "center_order_list_image")
        oneListView.nameLabel.text = "我的订单"
        return oneListView
    }()
    
    lazy var twoListView: CenterOneView = {
        let twoListView = CenterOneView()
        twoListView.bgImageView.image = UIImage(named: "center_down_list_image")
        twoListView.nameLabel.text = "我的下载"
        return twoListView
    }()
    
    lazy var threeListView: CenterOneView = {
        let threeListView = CenterOneView()
        threeListView.bgImageView.image = UIImage(named: "center_focus_list_image")
        threeListView.nameLabel.text = "我的关注"
        return threeListView
    }()
    
    lazy var fourListView: CenterOneView = {
        let fourListView = CenterOneView()
        fourListView.bgImageView.image = UIImage(named: "center_history_list_image")
        fourListView.nameLabel.text = "浏览历史"
        return fourListView
    }()
    
    lazy var twoView: CenterTwoView = {
        let twoView = CenterTwoView()
        return twoView
    }()
    
    lazy var threeView: CenterThreeView = {
        let threeView = CenterThreeView()
        return threeView
    }()
    
    lazy var fourView: CenterFourView = {
        let fourView = CenterFourView()
        return fourView
    }()
    
    lazy var footImageView: UIImageView = {
        let footImageView = UIImageView()
        footImageView.image = UIImage(named: "center_foot_image")
        return footImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(iconImageView)
        addSubview(phoneLabel)
        addSubview(descLabel)
        addSubview(vipImageView)
        addSubview(settingBtn)
        addSubview(footImageView)
        addSubview(scrollView)
        
        scrollView.addSubview(oneBgView)
        oneBgView.addSubview(stackView)
        bgImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(194.pix())
        }
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20.pix())
            make.left.equalToSuperview().offset(20.pix())
            make.size.equalTo(CGSize(width: 55.pix(), height: 55.pix()))
        }
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top)
            make.left.equalTo(iconImageView.snp.right).offset(8.pix())
            make.height.equalTo(28.pix())
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(6.5.pix())
            make.left.equalTo(iconImageView.snp.right).offset(8.pix())
            make.height.equalTo(16.5.pix())
        }
        vipImageView.snp.makeConstraints { make in
            make.centerY.equalTo(phoneLabel.snp.centerY)
            make.left.equalTo(phoneLabel.snp.right).offset(12)
            make.size.equalTo(CGSize(width: 60.pix(), height: 19.pix()))
        }
        settingBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-17.5.pix())
            make.centerY.equalTo(phoneLabel.snp.centerY)
            make.size.equalTo(CGSize(width: 25.pix(), height: 25.pix()))
        }
        footImageView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-6.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 232.5.pix(), height: 49.pix()))
        }
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(20.pix())
            make.bottom.equalTo(footImageView.snp.top).offset(-20.pix())
        }
        oneBgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 77.5.pix()))
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(oneListView)
        stackView.addArrangedSubview(twoListView)
        stackView.addArrangedSubview(threeListView)
        stackView.addArrangedSubview(fourListView)
        
        scrollView.addSubview(twoView)
        twoView.snp.makeConstraints { make in
            make.top.equalTo(oneBgView.snp.bottom).offset(8.pix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(60.pix())
        }
        scrollView.addSubview(threeView)
        scrollView.addSubview(fourView)
        
        threeView.snp.makeConstraints { make in
            make.top.equalTo(twoView.snp.bottom).offset(8.pix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(115.5.pix())
        }
        
        fourView.snp.makeConstraints { make in
            make.top.equalTo(threeView.snp.bottom).offset(10.pix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(234.5.pix())
            make.bottom.equalToSuperview().offset(-5.pix())
        }
        
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
