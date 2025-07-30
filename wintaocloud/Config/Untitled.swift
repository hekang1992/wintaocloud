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

final class DeviceIdfvManager {
    
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
