//
//  RegisterImageEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

struct RegisterImageEntity : Decodable {
    var success : Bool
    var response : RegisterImageResponse?
    var error : RegisterImageError?
}

struct RegisterImageResponse : Decodable {
    var pictureIdx : Int?
}

struct RegisterImageError : Decodable {
    var message : String?
    var status : Int?
}
