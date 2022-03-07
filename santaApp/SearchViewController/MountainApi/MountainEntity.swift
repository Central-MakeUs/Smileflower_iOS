//
//  MountainEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/16.
//

struct MountainEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [MountainResult]?
}

struct MountainResult : Decodable {
    var mountainIdx : Int?
    var mountainImg : String?
    var mountainName : String?
    var difficulty : Int?
    var intTypeHigh : Int?
    var hot : String?
    var pick : String?
}
