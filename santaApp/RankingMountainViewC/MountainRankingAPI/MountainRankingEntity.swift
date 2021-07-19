//
//  MountainRankingEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/19.
//

struct MountainRankingEntity : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : MountainRankingResult?
}

struct MountainRankingResult : Decodable {
    var myRank : MountainRankingMyRank?
    var allRank : [MountainRankingAllRank]?
}

struct MountainRankingMyRank : Decodable {
    var ranking : Int?
    var userIdx : Int?
    var userName : String?
    var userImage : String?
    var flagCount : Int?
    var agoTime : String?
}

struct MountainRankingAllRank : Decodable {
    var ranking : Int?
    var userIdx : Int?
    var userName : String?
    var userImage : String?
    var flagCount : Int?
    var agoTime : String?
}
