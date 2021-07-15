//
//  HomeVIewEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/13.
//

struct HomeViewEntity : Decodable {
    var result : DataResult?
    var isSuccess : Bool
    var code : Int
    var message : String
}

struct DataResult : Decodable {
    var userIdx : Int
    var userImage : String?
    var homeStatus : String
    var myflag : DataMyFlag?
}

struct DataMyFlag : Decodable {
    var mountain : [DataMyFlagMountain]?
}

struct DataMyFlagMountain : Decodable {
    var mountainIdx : Int
    var mountainName : String?
    var mountainImage : String?
    var difficulty : Int
    var userName : String
    var userImage : String?
    var flagCount : Int
}
