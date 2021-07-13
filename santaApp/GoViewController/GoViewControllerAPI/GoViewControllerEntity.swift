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
    var result : GoViewControllerEntityResult?
}
struct GoViewControllerEntityResult : Decodable {
    var mountainIdx : Int
    var mountain : String
}
