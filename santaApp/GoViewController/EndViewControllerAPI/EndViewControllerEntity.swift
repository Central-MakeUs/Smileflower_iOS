//
//  EndViewControllerEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

struct EndViewControllerEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : EndViewControllerResponse?
}

struct EndViewControllerResponse : Decodable {
    var flag : Bool?
    var doubleVisited : Bool?
    var fileUrl : String?
}

