//
//  MountainInfoEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/19.
//

struct MountainInfoEntity : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : MountainInfoResult?
}

struct MountainInfoResult : Decodable {
    var info : MountainInfoInfo?
    var road : [MountainInfoRoad]?
}

struct MountainInfoInfo : Decodable {
    var mountainIdx : Int?
    var mountainImg : String?
    var mountainName : String?
    var address : String?
    var difficulty : Int?
    var high : String?
    var hot : String?
    var pick : String?
}

struct MountainInfoRoad : Decodable {
    var roadIdx : Int?
    var courseNum : String?
    var difficulty : Int?
    var length : String?
    var time : String?
    var course : String?
    var latitude : Double?
    var longitude : Double?
}
