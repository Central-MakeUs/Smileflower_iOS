//
//  PostDeleteEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

struct PostsDeleteEntity : Decodable{
    var success : Bool
    var response : PostsDeleteResponse?
    var error : PostsDeleteError?
}

struct PostsDeleteResponse : Decodable {
    var success : Bool?
}

struct PostsDeleteError : Decodable {
    var message : String?
    var status : Int?
}
