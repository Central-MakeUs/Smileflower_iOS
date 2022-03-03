//
//  ShowUserResultEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/22.
//

struct ShowUserResutlEntity : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result: ShowUserResultResponse?
}

struct ShowUserResultResponse : Decodable {
    var firstFlag: Bool
    var thirdFlag : Bool
    var seventhFlag : Bool
    var tenthFlag : Bool
    var fiveHigh : Bool
    var tenHigh : Bool
    var twentyHigh : Bool
    var master : Bool
    var thirdMountain : Bool
    var seventhMountain : Bool
    var tenthMountain : Bool
    var high : Double?
}
