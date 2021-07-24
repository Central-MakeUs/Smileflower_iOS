//
//  FOrgetPasswordEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/24.
//

struct ForgetPasswordEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : String?
}
