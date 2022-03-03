//
//  DetailPostEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

struct DetailPostsEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : DetailPostsResponse?
}

struct DetailPostsResponse : Decodable{
    var userIdx : Int?
    var name : String?
    var posts : [DetailPostsPosts]?
}

struct DetailPostsPosts : Decodable {
    var isFlag : Bool?
    var flagIdx : Int?
    var pictureIdx : Int?
    var userIdx : Int?
    var flagCount : Int?
    var mountainIdx : Int?
    var name : String?
    var createdAt : String?
    var pictureUrl : String?
}

