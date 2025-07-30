//
//  NetworkManager.swift
//  wintaocloud
//
//  Created by 何康 on 2025/7/30.
//  网络监听

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private var reachaManager: NetworkReachabilityManager?
    
    private init() {
        self.reachaManager = NetworkReachabilityManager()
    }
    
    func startListening() {
        self.reachaManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                break
            case .reachable(.ethernetOrWiFi):
                self.stopListening()
                NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil)
                break
            case .reachable(.cellular):
                self.stopListening()
                NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil)
                break
            case .unknown:
                break
            }
        })
    }
    
    func stopListening() {
        self.reachaManager?.stopListening()
    }
    
}


