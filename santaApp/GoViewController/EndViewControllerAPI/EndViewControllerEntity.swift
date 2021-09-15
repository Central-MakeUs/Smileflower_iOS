//
//  EndViewControllerEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

struct EndViewControllerEntity : Decodable {
    var success : Bool
    var response : EndViewControllerResponse?
    var error : EndViewControllerError?
}

struct EndViewControllerResponse : Decodable {
    var isFlag : Bool?
    var isDoubleVisited : Bool?
    var fileUrl : String?
}

struct EndViewControllerError : Decodable {
    var message : String?
    var status : Int?
}
