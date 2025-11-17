//
//  Extension.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import SnapKit

extension Double {
    func pix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension CGFloat {
    func pix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension Int {
    func pix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension UIFont {
    class func regularFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size.pix(), weight: .regular)
    }
    
    class func mediumFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size.pix(), weight: .medium)
    }
    
    class func semiboldFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size.pix(), weight: .semibold)
    }
    
    class func boldFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size.pix(), weight: .bold)
    }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        if hexFormatted.hasPrefix("0X") {
            hexFormatted = String(hexFormatted.dropFirst(2))
        }
        
        var hexValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&hexValue)
        
        self.init(hex: UInt32(hexValue), alpha: alpha)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(red: randomNumber(),
                       green: randomNumber(),
                       blue: randomNumber(),
                       alpha: 1.0)
    }
    
    private class func randomNumber() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
}


final class Loading {
    
    // MARK: - Singleton
    static let shared = Loading()
    private init() {}
    
    // MARK: - Views
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private var isShowing = false
    
    // MARK: - Public Methods
    
    static func show() {
        DispatchQueue.main.async {
            shared.showInternal()
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            shared.hideInternal()
        }
    }
    
    // MARK: - Private Methods
    
    private func showInternal() {
        guard !isShowing else { return }
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else { return }
        
        isShowing = true
        
        overlayView.addSubview(containerView)
        containerView.addSubview(indicator)
        window.addSubview(overlayView)
        
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        indicator.startAnimating()
    }
    
    private func hideInternal() {
        guard isShowing else { return }
        isShowing = false
        
        indicator.stopAnimating()
        containerView.removeFromSuperview()
        overlayView.removeFromSuperview()
    }
}
