//
//  LoginConfig.swift
//  wintaocloud
//
//  Created by 何康 on 2025/7/30.
//

import Foundation

let WDY_PHONE = "WDY_PHONE"
let WDY_SESSIONID = "WDY_SESSIONID"
let WDY_CUSTOMERNUMBER = "WDY_CUSTOMERNUMBER"
let WDY_USER_ID = "WDY_USER_ID"

var IS_LOGIN: Bool {
    if let sessionID = UserDefaults.standard.object(forKey: WDY_SESSIONID) as? String {
        return !sessionID.isEmpty
    } else {
        return false
    }
}

class WDLoginConfig: NSObject {
    
    static func saveLoginInfo(_ phone: String, _ sessionID: String, _ customerNumber: String, _ userID: String) {
        UserDefaults.standard.setValue(phone, forKey: WDY_PHONE)
        UserDefaults.standard.setValue(sessionID, forKey: WDY_SESSIONID)
        UserDefaults.standard.setValue(customerNumber, forKey: WDY_CUSTOMERNUMBER)
        UserDefaults.standard.setValue(userID, forKey: WDY_USER_ID)
        UserDefaults.standard.synchronize()
    }
    
    static func removeLoginInfo() {
        GetCacheConfig.clearCache()
        UserDefaults.standard.setValue("", forKey: WDY_PHONE)
        UserDefaults.standard.setValue("", forKey: WDY_SESSIONID)
        UserDefaults.standard.setValue("", forKey: WDY_CUSTOMERNUMBER)
        UserDefaults.standard.setValue("", forKey: WDY_USER_ID)
        UserDefaults.standard.synchronize()
    }
    
}

//获取登录数据
class GetSaveLoginInfoConfig {
    
    static func getCustomerNumber() -> String {
        let customernumber = UserDefaults.standard.object(forKey: WDY_CUSTOMERNUMBER) as? String ?? ""
        return customernumber
    }
    
    static func getPhoneNumber() -> String {
        let phoneNum = UserDefaults.standard.object(forKey: WDY_PHONE) as? String ?? ""
        return phoneNum
    }
    
    static func getSessionID() -> String {
        let token = UserDefaults.standard.object(forKey: WDY_SESSIONID) as? String ?? ""
        return token
    }
    
    static func getUserID() -> String {
        let userID = UserDefaults.standard.object(forKey: WDY_USER_ID) as? String ?? ""
        return userID
    }
    
    
}


//获取缓存方法
class GetCacheConfig {
    /// 获取缓存大小，单位为 MB
    static func getCacheSizeInMB() -> String {
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        var totalSize: UInt64 = 0
        
        if let enumerator = FileManager.default.enumerator(at: cacheURL, includingPropertiesForKeys: [.totalFileAllocatedSizeKey], options: [], errorHandler: nil) {
            for case let fileURL as URL in enumerator {
                do {
                    let resourceValues = try fileURL.resourceValues(forKeys: [.totalFileAllocatedSizeKey])
                    if let fileSize = resourceValues.totalFileAllocatedSize {
                        totalSize += UInt64(fileSize)
                    }
                } catch {
                    print("Error getting file size: \(error)")
                }
            }
        }
        
        // 将字节转换为 MB
        let sizeInMB = Double(totalSize) / (1024 * 1024)
        return String(format: "%.2f MB", sizeInMB)
    }
    
    static func clearCache() {
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: cacheURL, includingPropertiesForKeys: nil, options: [])
            for fileURL in contents {
                try FileManager.default.removeItem(at: fileURL)
            }
            print("Cache cleared successfully.")
        } catch {
            print("Error clearing cache: \(error)")
        }
    }
    
}
