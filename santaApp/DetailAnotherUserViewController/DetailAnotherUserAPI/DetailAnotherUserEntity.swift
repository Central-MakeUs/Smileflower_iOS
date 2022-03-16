//
//  DetailPostEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

struct DetailUserPostsEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : DetailUserPostsResponse?
}

struct DetailUserPostsResponse : Decodable{
    var userIdx : Int?
    var name : String?
    var getPostsRes : [DetailUserPostsPosts]?
}

struct DetailUserPostsPosts : Decodable {
    var flag : Bool?
    var flagIdx : Int?
    var pictureIdx : Int?
    var userIdx : Int?
    var userImageUrl : String?
    var level : String?
    var userName : String?
    var flagCount : Int?
    var mountainIdx : Int?
    var name : String?
    var saveCount : Int?
    var isSaved : String?
    var createdAt : String?
    var pictureUrl : String?
    var getCommentRes: [DetailUserPostsComment]?
}

struct DetailUserPostsComment : Decodable {
    var userIdx: Int?
    var userImageUrl : String?
    var userName: String?
    var contents: String?
    var count : Int?
}

