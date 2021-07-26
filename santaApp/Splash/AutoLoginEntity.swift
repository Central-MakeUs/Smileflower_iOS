//
//  AutoLoginEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/16.
//

struct AutoLoginEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : AutoLoginResult?
}

struct AutoLoginResult : Decodable {
    var status : String?
    var userIdx : Int?
    var emailId : String?
}
