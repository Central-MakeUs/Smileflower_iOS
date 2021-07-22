//
//  ShowProlfileEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/20.
//
import UIKit

struct ShowProfileEntity : Decodable {
    var success : Bool
    var response : ShowProfileResponse?
    var error : ShowProfileError?
}

struct ShowProfileResponse : Decodable {
    var userIdx : Int?
    var name : String?
    var level : Int?
    var flagCount : Int?
    var postCount : Int?
    var fileUrl : String?
    var posts : [ShowProfilePosts]?
}

struct ShowProfilePosts : Decodable {
    var isFlag : Bool?
    var flagIdx : Int?
    var pictureIdx : Int?
    var userIdx : Int?
    var flagCount : Int?
    var mountainIdx : Int?
    var name : String?
    var createdAt : String?
    var pictureUrl : String?
}

struct ShowProfileError : Decodable {
    var message : String?
    var status : Int?
}
