//
//  LogoutEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/16.
//

struct LogoutEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : LogoutResult?
}
struct LogoutResult : Decodable {
    var inx : Int?
    var userIdx : Int?
    var status : String?
    var name : String?
    var resultMes : String?
}
