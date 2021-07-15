//
//  CompleteSignUpEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

struct CompleteSignUpEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : CompleteSignUpResult?
}

struct CompleteSignUpResult : Decodable {
    var jwt : String
    var userIdx : Int
}
