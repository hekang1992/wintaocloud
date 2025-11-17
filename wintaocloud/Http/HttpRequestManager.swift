//
//  HttpRequestManager.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import Alamofire

struct APIHeader {
    static var defaultHeaders: HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Connection": "keep-alive",
            "x-sld-client-version": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        ]
        
        if let sessionID = UserDefaults.standard.string(forKey: WDY_SESSIONID) {
            headers.add(name: "Authorization", value: "Bearer \(sessionID)")
        }
        return headers
    }
}

final class HttpRequestManager {
    static let shared = HttpRequestManager()
    private init() {}
    
    /// 用于取消重复请求
    private var requestCache: [String: Request] = [:]
}


// MARK: - Async Networking
extension HttpRequestManager {
    
    /// 核心请求方法
    func request(
        _ url: String,
        method: HTTPMethod,
        params: Parameters? = nil
    ) async throws -> Data {
        
        // 如果已有正在执行的相同 URL 请求 → 取消掉
        if let old = requestCache[url] {
            old.cancel()
        }
        
        let fullURL = url
        
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self = self else { return }
            
            print("🌐 Request: \(method.rawValue) \(fullURL)")
            print("📌 Params: \(params ?? [:])")
            
            let req = AF.request(
                fullURL,
                method: method,
                parameters: params,
                encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                headers: APIHeader.defaultHeaders
            )
            .validate()
            .responseData { [weak self] response in
                
                // 请求完成 → 移除缓存
                self?.requestCache.removeValue(forKey: url)
                
                switch response.result {
                case .success(let data):
                    print("✅ Success: \(fullURL)")
                    continuation.resume(returning: data)
                    
                case .failure(let error):
                    print("❌ Error: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                }
            }
            
            // 缓存当前请求，用于取消
            self.requestCache[url] = req
        }
    }
}



// MARK: - GET / POST 简化方法
extension HttpRequestManager {
    
    func get(
        _ url: String,
        params: Parameters? = nil
    ) async throws -> Data {
        let fullURL = base_url + url
        return try await request(fullURL, method: .get, params: params)
    }

    func post(
        _ url: String,
        params: Parameters? = nil
    ) async throws -> Data {
        let fullURL = base_url + url
        return try await request(fullURL, method: .post, params: params)
    }
}



// MARK: - Cancel methods
extension HttpRequestManager {
    
    func cancelRequest(_ url: String) {
        requestCache[url]?.cancel()
        requestCache.removeValue(forKey: url)
    }
    
    func cancelAll() {
        requestCache.values.forEach { $0.cancel() }
        requestCache.removeAll()
    }
}

