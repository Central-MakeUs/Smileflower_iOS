//
//  ChangeProfileEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

struct ChangeProfileEntity : Decodable {
    var success : Bool
    var response : ChangeProfileResponse?
    var error : ChangeProfileError?
}
struct ChangeProfileResponse : Decodable {
    var fileUrl : String?
}
struct ChangeProfileError : Decodable {
    var message : String?
    var status : Int?
}
