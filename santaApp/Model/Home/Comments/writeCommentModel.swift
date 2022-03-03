//
//  WriteComment.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/03.
//

struct writeCommentModel : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : writeCommentResult?
}

struct writeCommentResult : Decodable{
    var commentidx : Int?
}
