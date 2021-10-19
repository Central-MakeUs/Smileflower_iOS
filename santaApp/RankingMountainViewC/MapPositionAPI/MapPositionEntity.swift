//
//  MapPositionEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/17.
//

struct MapPositionEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : MapPositionResult?
}
struct MapPositionResult : Decodable {
    var mountain : MapPositionMountain?
    var road : [MapPositionRoad]?
}

struct MapPositionMountain : Decodable {
    var latitude : Double?
    var longitude : Double?
}

struct MapPositionRoad : Decodable {
    var roadIdx : Int?
    var courseNum : String?
    var difficulty : Int?
    var length : String?
    var time : String?
    var course : String?
    var latitude : Double?
    var longitude : Double?
}
