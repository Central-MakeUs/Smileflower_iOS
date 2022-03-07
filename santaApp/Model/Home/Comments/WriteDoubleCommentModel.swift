//
//  WriteDoubleCommentModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/03.
//

struct WriteDoubleCommentModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : WriteDoubleCommentResult?
}

struct WriteDoubleCommentResult : Decodable {
    var recommentidx : Int?
}
