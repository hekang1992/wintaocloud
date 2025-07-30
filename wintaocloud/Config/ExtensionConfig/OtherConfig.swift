//
//  Untitled.swift
//  wintaocloud
//
//  Created by 何康 on 2025/7/30.
//

import DeviceKit
import AppTrackingTransparency
import AdSupport
import SAMKeychain

//获取IDFA-IDFV
class DeviceIdfvManager {
    
    static let shared = DeviceIdfvManager()
    
    private let serviceName = "com.wentao.ald"
    private let accountName = "IDFV"
    
    func getIDFA() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    func getDeviceID() -> String {
        if let existingID = try? retrieveDeviceIDFromKeychain() {
            return existingID
        }
        
        let newID = generateNewDeviceID()
        
        storeDeviceIDInKeychain(newID)
        
        return newID
    }
    
    private func retrieveDeviceIDFromKeychain() throws -> String {
        if let deviceID = SAMKeychain.password(forService: serviceName, account: accountName) {
            return deviceID
        }
        throw KeychainError.deviceIDNotFound
    }
    
    private func generateNewDeviceID() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }
    
    private func storeDeviceIDInKeychain(_ id: String) {
        let success = SAMKeychain.setPassword(id, forService: serviceName, account: accountName)
        if !success {
            print("Failed to store device ID in keychain")
        }
    }
    
    private enum KeychainError: Error {
        case deviceIDNotFound
        case keychainAccessFailed
    }
}

//图片压缩
class ImageProviderData {
    static func compressImage(_ image: UIImage, maxKB: Int = 500) -> Data? {
        let maxBytes = maxKB * 1024
        var compression: CGFloat = 0.9
        var imageData: Data?
        var currentImage = image
        for _ in 0..<6 {
            imageData = currentImage.jpegData(compressionQuality: compression)
            if let data = imageData, data.count <= maxBytes {
                return data
            }
            compression -= 0.15
        }
        
        var scale: CGFloat = 0.8
        while scale >= 0.3 {
            let newSize = CGSize(
                width: currentImage.size.width * scale,
                height: currentImage.size.height * scale
            )
            UIGraphicsBeginImageContext(newSize)
            currentImage.draw(in: CGRect(origin: .zero, size: newSize))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            guard let resizedImage = resizedImage else { break }
            currentImage = resizedImage
            imageData = currentImage.jpegData(compressionQuality: 0.5)
            if let data = imageData, data.count <= maxBytes {
                return data
            }
            scale -= 0.1
        }
        return imageData
    }
}

//震动反馈
class HapticFeedbackManager {
    
    // 通用的振动反馈方法
    static func triggerImpactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.prepare()  // 可选：提前准备
        feedbackGenerator.impactOccurred()  // 触发振动
    }
    
    // 通知反馈（成功、错误、警告）
    static func triggerNotificationFeedback(type: UINotificationFeedbackGenerator.FeedbackType) {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.prepare()  // 可选：提前准备
        feedbackGenerator.notificationOccurred(type)  // 触发振动
    }
    
    // 选择反馈（例如滚动选择器）
    static func triggerSelectionFeedback() {
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.prepare()  // 可选：提前准备
        feedbackGenerator.selectionChanged()  // 触发振动
    }
}
