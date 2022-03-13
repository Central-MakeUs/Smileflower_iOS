//
//  HomeModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/01/05.
//

struct HomeModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : HomeModelResult?
}

struct HomeModelResult : Decodable {
    var notice : String
    var isFirst: String?
    var getFlagResList : [HomeModelPictureList]?
    var getUsersResList : [HomeModelUserList]?
    var getMountainsResList : [HomeModelMountainsList]?
}

struct HomeModelPictureList : Decodable {
    var userIdx : Int?
    var userImageUrl : String?
    var level : String?
    var userName : String?
    var commentCount : Int?
    var isSaved: String?
    var saveCount : Int?
    var flagIdx : Int?
    var flagImageUrl : String?
}

struct HomeModelUserList : Decodable {
    var userIdx : Int?
    var userImageUrl : String?
    var level : String?
    var userName : String?
    var agoTime : String?
    var height : String?
}

struct HomeModelMountainsList : Decodable {
    var mountainIdx : Int?
    var mountainImageUrl : String?
    var isHot : String?
    var difficulty : Int?
    var mountainName : String?
    var intTypeHigh : Int?
    var userIdx : Int?
    var userImageUrl : String?
}
