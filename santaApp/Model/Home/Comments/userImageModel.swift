//
//  userImageModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/03.
//

struct userImageModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : userImageResult?
}

struct userImageResult : Decodable {
    var userImageUrl : String?
}
