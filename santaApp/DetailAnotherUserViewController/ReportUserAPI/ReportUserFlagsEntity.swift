//
//  ReportUserEntity.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/22.
//

struct ReportUserFlagsEntity : Decodable {
    var success : Bool
    var response : ReportUserFlagsResponse?
    var error : ReportUserFlagsError?
}

struct ReportUserFlagsResponse : Decodable {
    var flagIdx : Int?
    var reportCnt : Int?
}

struct ReportUserFlagsError : Decodable {
    var message : String?
    var status : Int?
}
