//
//  HttpRequsetManager.swift
//  wintaocloud
//
//  Created by 何康 on 2025/7/30.
//  网络请求

import Alamofire

//let base_url = "http://h5.w.com"
let base_url = "https://h5.wintaocloud.com"

class HttpRequsetManager {
    static let shared = HttpRequsetManager()
    private init() {}
    
    private var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/json"
        headers["Connection"] = "keep-alive"
        headers["x-sld-client-version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        var sessionID: String = ""
        if let sessionId: String = UserDefaults.standard.object(forKey: WDY_SESSIONID) as? String {
            sessionID = sessionId
        }
        headers["Authorization"] = "Bearer " + sessionID
        return headers
    }
    
    func getRequest(
        url: String,
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<BaseModel, Error>) -> Void
    ) {
        let apiUrl = base_url + url
        AF.request(
            apiUrl,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: BaseModel.self) { response in
            self.handleResponse(response, completion: completion)
        }
    }
    
    func postRequest(
        url: String,
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<BaseModel, Error>) -> Void
    ) {
        let apiUrl = base_url + url
        AF.request(
            apiUrl,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: BaseModel.self) { response in
            self.handleResponse(response, completion: completion)
        }
    }
    
    func postMultipartFormRequest(
        url: String,
        parameters: [String: Any],
        completion: @escaping (Result<BaseModel, Error>) -> Void
    ) {
        let apiUrl = base_url + url
        
        AF.upload(
            multipartFormData: { multipartFormData in
                
                for (key, value) in parameters {
                    if let stringValue = "\(value)".data(using: .utf8) {
                        multipartFormData.append(stringValue, withName: key)
                    }
                }
                
            },
            to: apiUrl,
            method: .post,
            headers: headers
        )
        .validate()
        .responseDecodable(of: BaseModel.self) { response in
            self.handleResponse(response, completion: completion)
        }
    }
    
    
    func uploadImage(
        url: String,
        image: UIImage,
        imageName: String? = nil,
        parameters: [String: String]? = nil,
        completion: @escaping (Result<BaseModel, Error>) -> Void
    ) {
        guard let imageData = ImageProviderData.compressImage(image) else {
            let error = NSError(domain: "NetworkError", code: -1,
                                userInfo: [NSLocalizedDescriptionKey: "failure_image"])
            completion(.failure(error))
            return
        }
        let fileName = imageName ?? "\(Int(Date().timeIntervalSince1970)).jpg"
        let apiUrl = base_url + url
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(
                    imageData,
                    withName: "metrally",
                    fileName: fileName,
                    mimeType: "image/jpeg"
                )
                parameters?.forEach { key, value in
                    if let valueData = value.data(using: .utf8) {
                        multipartFormData.append(valueData, withName: key)
                    }
                }
            },
            to: apiUrl,
            headers: headers
        )
        .validate()
        .uploadProgress { progress in
            print("progress======: \(progress.fractionCompleted)")
        }
        .responseDecodable(of: BaseModel.self) { response in
            self.handleResponse(response, completion: completion)
        }
    }
    
    private func handleResponse(
        _ response: DataResponse<BaseModel, AFError>,
        completion: @escaping (Result<BaseModel, Error>) -> Void
    ) {
        switch response.result {
        case .success(let value):
            completion(.success(value))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

//参数拼接
class URLQueryConfig {
    static func appendQueryDict(to urlString: String, parameters: [String: String]) -> String? {
        guard var components = URLComponents(string: urlString) else { return nil }
        let existingItems = components.queryItems ?? []
        let newItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.queryItems = existingItems + newItems
        return components.url?.absoluteString
    }
    
}
