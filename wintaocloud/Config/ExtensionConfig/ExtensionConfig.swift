//
//  ExtensionConfig.swift
//  wintaocloud
//
//  Created by 何康 on 2025/7/30.
//

import UIKit


let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

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

//颜色
extension UIColor {
    convenience init?(cssStr: String) {
        let hexString = cssStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        guard hexString.hasPrefix("#") else {
            return nil
        }
        let hexCode = hexString.dropFirst()
        guard hexCode.count == 6, let rgbValue = UInt64(hexCode, radix: 16) else {
            return nil
        }
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    class func random() -> UIColor {
        return UIColor(red: randomNumber(),
                       green: randomNumber(),
                       blue: randomNumber(),
                       alpha: 1.0)
    }
    
    private class func randomNumber() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
}
