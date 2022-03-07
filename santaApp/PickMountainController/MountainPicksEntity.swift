//
//  MountainPicksEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/17.
//

struct MountainPicksEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [MountainPicksResult]?
}

struct MountainPicksResult : Decodable {
    var mountainIdx : Int?
    var mountainName : String?
    var mountainImg : String?
    var difficulty : Int?
    var intTypeHigh : Int?
}
