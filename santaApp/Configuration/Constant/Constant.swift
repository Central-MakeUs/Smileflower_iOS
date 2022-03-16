//
//  Constant.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import Alamofire

struct Constant {
    #if DEV
    static let baseURL = "https://test.smilesanta.site"
    #else
    static let baseURL = "https://smilesanta.site"
    #endif
    static let TestURL = "https://test.smilesanta.site"
    static let MainURL = "https://smilesanta.site"
    static let fontCocogoose = "Cocogoose"
    static var JWTToken = ""
    static var userIdx : Int?
    static var userEmail : String?
    static var deviceToken = ""
    static var pushToken = ""
    static var loginMethod = ""
    
    static var userPhoneHeight: CGFloat = 0
    static var userPhoneWidth : CGFloat = 0
    
    static let fontAppleSDGothicNeoRegular = "AppleSDGothicNeo-Regular"
    static let fontAppleSDGothicNeoThin = "AppleSDGothicNeo-Thin"
    static let fontAppleSDGothicNeoUltraLight = "AppleSDGothicNeo-UltraLight"
    static let fontAppleSDGothicNeoLight = "AppleSDGothicNeo-Light"
    static let fontAppleSDGothicNeoMedium = "AppleSDGothicNeo-Medium"
    static let fontAppleSDGothicNeoSemiBold = "AppleSDGothicNeo-SemiBold"
    static let fontAppleSDGothicNeoBold = "AppleSDGothicNeo-Bold"
    static let fontAppleSDGothicNeoExtraBold = "AppleSDGothicNeo-ExtraBold"
    static let fontAppleSDGothicNeoHeavy = "AppleSDGothicNeo-Heavy"
    static let fontWowFont = "ygotjalnanfontOTF"
}
