//
//  GoViewControllerEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/13.
//

struct GoViewControllerEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [GoViewControllerResult]?
}
struct GoViewControllerResult : Decodable {
    var mluntainIdx : Int
    var mountain : String
}
