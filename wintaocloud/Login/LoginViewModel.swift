//
//  LoginViewModel.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import Foundation

class LoginViewModel {
    
    func getLoginCodeApi(with json: [String: Any]) async throws -> BaseModel {
        
        defer {
            Loading.hide()
        }

        Loading.show()
        
        let data = try await HttpRequestManager.shared.get(
            "/prod-api/operation/enterpriseclientbm/buymoreinfo",
            params: json
        )
        let model = try JSONDecoder().decode(BaseModel.self, from: data)
        return model
    }
    
}
