//
//  FlagsDeleteEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/22.
//

struct FlagsDeleteEntity : Decodable {
    var issuccess : Bool
    var code : Int
    var message : String
    var result : FlagsDeleteResponse?
}

struct FlagsDeleteResponse : Decodable {
    var success : Bool?
}

