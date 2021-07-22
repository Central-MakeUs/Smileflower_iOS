//
//  FlagsDeleteEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/22.
//

struct FlagsDeleteEntity : Decodable {
    var success : Bool
    var response : FlagsDeleteResponse?
    var error : FlagsDeleteError?
}

struct FlagsDeleteResponse : Decodable {
    var success : Bool?
}

struct FlagsDeleteError : Decodable {
    var message : String?
    var status : Int?
}
