//
//  SignInViewControllerInput.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

struct SignInViewControllerInput : Encodable {
    var emailId : String
    var password : String
    var pushToken : String
    var tokenType : String
}
