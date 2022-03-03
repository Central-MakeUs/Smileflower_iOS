//
//  ChangeProfileEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

struct ChangeProfileEntity : Decodable {
    var isSuccess : Bool
    var message : String
    var code : Int
    var result : ChangeProfileResponse?
}
struct ChangeProfileResponse : Decodable {
    var fileUrl : String?
}
