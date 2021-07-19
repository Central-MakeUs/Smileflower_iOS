//
//  MountainSearchEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/19.
//

struct MountainSearchEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : MountainSearchResult?
}

struct MountainSearchResult : Decodable {
    var mountainIdx : Int?
}
