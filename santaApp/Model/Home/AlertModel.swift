//
//  AlertModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/10.
//

struct AlertModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [AlertResult]?
}

struct AlertResult: Decodable {
    var notificationIdx : Int
    var flagIdx : Int?
    var type : String?
    var status : String?
    var contents : String?
    var CreatedAt : String?
}
