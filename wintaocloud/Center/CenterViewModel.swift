//
//  CenterViewModel.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import Foundation

class CenterViewModel {
    
    /// 获取个人中心页面数据
    func getCenterInitApi(with json: [String: Any]) async throws -> BaseModel {
        
//        defer {
//            Loading.hide()
//        }
//        
//        Loading.show()
        
        let data = try await HttpRequestManager.shared.get(
            "/prod-api/operation/enterpriseclientbm/buymoreinfo",
            params: json
        )
        let model = try JSONDecoder().decode(BaseModel.self, from: data)
        return model
    }
    
    /// 是否是为分销商
    func judegChnnelpartnerApi(with json: [String: Any]) async throws -> BaseModel {
        
//        defer {
//            Loading.hide()
//        }
//        
//        Loading.show()
        
        let data = try await HttpRequestManager.shared.get(
            "/prod-api/operation/partner/ischnnelpartner",
            params: json
        )
        let model = try JSONDecoder().decode(BaseModel.self, from: data)
        return model
    }
    
}
