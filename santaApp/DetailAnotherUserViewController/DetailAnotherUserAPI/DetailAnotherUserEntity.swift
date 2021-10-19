//
//  DetailPostEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

struct DetailAnotherUserResult : Decodable {
    var success : Bool
    var response : DetailAnotherUserResponse?
    var error : DetailAnotherUserError?
}

struct DetailAnotherUserResponse : Decodable{
    var userIdx : Int?
    var name : String?
    var posts : [DetailAnotherUserPosts]?
}

struct DetailAnotherUserPosts : Decodable {
    var isFlag : Bool?
    var flagIdx : Int?
    var picturesIdx : Int?
    var userIdx : Int?
    var flagCount : Int?
    var mountainIdx : Int?
    var name : String?
    var createdAt : String?
    var pictureUrl : String?
}

struct DetailAnotherUserError : Decodable{
    var message : String?
    var status : Int?
}
