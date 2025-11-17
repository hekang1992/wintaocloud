//
//  AppModel.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

class BaseModel: Codable {
    var msg: String?
    var code: Int?
    var data: dataModel?
}

class dataModel: Codable {
    var customernumber: String?
    var accounttype: Int?
    var viplevel: String?
    var userIdentity: String?
    var endtime: String?
    var combonumber: Int?
}
