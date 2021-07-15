//
//  SignInViewControllerEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

struct SignInViewControllerEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : SignInViewControllerResult?
}

struct SignInViewControllerResult : Decodable {
    var jwt : String
    var userIdx : Int
    var name : String
    var status : String
}
