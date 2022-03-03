//
//  FlagMountainEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/23.
//

struct FlagMountainEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [FlagMountainResponse]?
}

struct FlagMountainResponse : Decodable {
    var userIdx : Int?
    var mountainIdx : Int?
    var mountainName : String?
    var imageUrl : String?
    var latitude : Double?
    var longitude : Double?
    var flagCount : Int?
    var address : String?
}
