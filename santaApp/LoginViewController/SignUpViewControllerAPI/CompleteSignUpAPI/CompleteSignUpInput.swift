//
//  CompleteSignUpInput.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

struct CompleteSignUpInput : Encodable {
    var emailId : String
    var name : String
    var password : String
    var passwordCheck : String
    var userImageUrl : String?
    var pushToken : String
    var tokenType : String
}
