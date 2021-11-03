//
//  ResignEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/11/04.
//

struct ResignEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : ResignResult?
}
struct ResignResult : Decodable {
    var userIdx : Int?
}
