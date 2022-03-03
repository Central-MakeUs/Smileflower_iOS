//
//  AppleLoginModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/26.
//

struct AppleLoginModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : AppleLoginResult?
}


struct AppleLoginResult : Decodable {
    var jwt : String?
    var userIdx : Int?
}
