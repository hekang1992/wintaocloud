//
//  BaseView.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import RxSwift

class BaseView: UIView {
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "#F4F6FC")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
