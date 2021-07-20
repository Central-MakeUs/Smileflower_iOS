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
    var flags : ShowProfileFlags?
    var pictures : ShowProfilePictures?
}

struct ShowProfileFlags : Decodable {
    var flagIdx : Int?
    var userIdx : Int?
    var mountainIdx : Int?
    var createdAt : String?
    var pictureUrl : String?
    var flagCount : Int?
    var name : String?
}

struct ShowProfilePictures : Decodable {
    var pictureIdx : Int?
    var userIdx : Int?
    var imageUrl : String?
    var createdAt : String?
}

struct ShowProfileError : Decodable {
    var message : String?
    var status : Int?
}
