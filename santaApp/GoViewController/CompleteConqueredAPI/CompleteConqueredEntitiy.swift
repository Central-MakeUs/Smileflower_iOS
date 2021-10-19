//
//  CompleteConqueredEntitiy.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/18.
//

struct CompleteConqueredEntity : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : CompleteConqueredResult?
}

struct CompleteConqueredResult : Decodable {
    var firstRank : CompleteConqueredFirstRank?
    var myRank : CompleteConqueredMyRank?
}


struct CompleteConqueredFirstRank : Decodable {
    var userIdx : Int?
    var userName : String?
    var userImage : String?
    var ranking : Int?
    var level : String?
    var flagCount : Int?
}

struct CompleteConqueredMyRank : Decodable {
    var userIdx : Int?
    var userName : String?
    var userImage : String?
    var ranking : Int?
    var level : String?
    var flagCount : Int
}
