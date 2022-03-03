//
//  KakaoLoginModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/26.
//

struct KakaoLoginModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : KakaoLoginResult?
}

struct KakaoLoginResult : Decodable {
    var jwt : String?
    var userIdx : Int?
}
