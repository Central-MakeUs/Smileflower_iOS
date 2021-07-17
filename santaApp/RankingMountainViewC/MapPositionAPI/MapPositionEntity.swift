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
    var latitude : Double?
    var longitude : Double?
}
