//
//  CheckNicnameEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

struct CheckNicnameEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : CheckNicnameResult?
}

struct CheckNicnameResult : Decodable {
    var status : String
    var bool : Bool
}
