//
//  RegisterImageEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

struct RegisterImageEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : RegisterImageResponse?
}

struct RegisterImageResponse : Decodable {
    var pictureIdx : Int?
}

