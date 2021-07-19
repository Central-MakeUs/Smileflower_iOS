//
//  MountainLikeEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/17.
//

struct MountainLikeEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : MountainLikeResult?
}

struct MountainLikeResult : Decodable {
    var picklistIdx : Int?
    var userIdx : Int?
    var mountainIdx : Int?
    var status : String?
    var result : String?
}
