//
//  sfa.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/12.
//

import UIKit
import AuthenticationServices

class AppleJSONController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLabel()
    }
    var userIdentifier : String = ""
    var fullNamegivenName : String = ""
    var fullnamegivenFamilyName : String = ""
    var email : String?
    var status : ASUserDetectionStatus?
    var code : Data?
    var token : Data?
    //MARK: 스크롤
    let scrollViwe = UIScrollView()
    let viewcontent = UIView()
    func setView() {
        view.addSubview(scrollViwe)
        scrollViwe.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        scrollViwe.addSubview(viewcontent)
        viewcontent.snp.makeConstraints { make in
            make.edges.equalTo(0)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.height + 500)
        }
    }
    //MARK: 에디 테스트
    let label =  UITextView()
    func setLabel() {
        let strcode = String(decoding: self.code!, as: UTF8.self)
        let strtoken = String(decoding: self.token!, as: UTF8.self)
        
        label.backgroundColor = .white
        label.textColor = .black
        label.text = "User ID : \(userIdentifier)\nUser Email : \(email ?? "")\nUserName : \((fullNamegivenName) + (fullnamegivenFamilyName))\nUserStatus : \(status!)\nUserCode : \(strcode)\nUserToken: \(strtoken)) "
        viewcontent.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(viewcontent.snp.top).offset(40)
            make.centerY.equalTo(viewcontent)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }
}
