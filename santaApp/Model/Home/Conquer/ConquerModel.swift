//
//  ConquerModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/01/29.
//

struct ConquerModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [ConquerResult]?
}

struct ConquerResult : Decodable {
    var userIdx : Int?
    var userImageUrl :String?
    var level : String?
    var userName :String?
    var isSaved : String?
    var commentCount : Int?
    var saveCount : Int?
    var flagIdx : Int?
    var flagImageUrl : String?
    var getCommentRes : [ConquergetCommentsRes]?
}

struct ConquergetCommentsRes : Decodable {
    var userIdx : Int?
    var userImageUrl : String?
    var status : String?
    var userName : String?
    var contents : String?
    var count : Int?
}
