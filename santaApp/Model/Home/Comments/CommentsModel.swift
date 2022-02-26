//
//  MessageModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/21.
//

struct CommentsModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [commentsResult]?
}

struct commentsResult : Decodable {
    var userIdx : Int?
    var userImageUrl : String?
    var userName : String?
    var isUsersComments: String?
    var commentIdx: Int?
    var contents: String?
    var status: String?
    var createdAt : String?
    var getRecommentRes : [messageComments]?
}

struct messageComments : Decodable {
    var userIdx : Int?
    var userImageUrl : String?
    var userName : String?
    var isUsersComments : String?
    var recommentIdx : Int?
    var contents: String?
    var status: String?
    var createdAt: String?
}
