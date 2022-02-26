//
//  FeedLikeModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/25.
//

struct FlagLikeModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : FlagLikeResult?
}

struct FlagLikeResult : Decodable {
    var picturesaveIdx : Int?
    var result : String?
}

struct PictureLikeModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : PictureLikeResult?
}

struct PictureLikeResult : Decodable {
    var flagsaveIdx : Int?
    var result : String?
}
