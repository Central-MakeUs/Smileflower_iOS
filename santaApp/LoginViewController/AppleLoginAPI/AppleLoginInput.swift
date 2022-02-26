//
//  AppleLoginInput.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/26.
//

struct AppleLoginInput : Encodable {
    var name : String?
    var userEmail : String?
    var userIdentifier : String?
    var authorizationCode : String?
    var identifyToken : String?
}
