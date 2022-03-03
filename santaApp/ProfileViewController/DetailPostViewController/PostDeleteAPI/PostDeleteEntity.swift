//
//  PostDeleteEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

struct PostsDeleteEntity : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var response : PostsDeleteResponse?
}

struct PostsDeleteResponse : Decodable {
    var success : Bool?
}
