//
//  AutoLoginDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/16.
//
import Alamofire
import UIKit

class AutoLoginDataManager {
    func appusersautologin(_ viewcontroller : SplashViewController) {
        if let token = UserDefaults.standard.string(forKey: "JWTToken"){
            let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : token ]
            AF.request(Constant.baseURL + "/app/users/auto-login", method: .get, headers: headers).validate().responseDecodable(of: AutoLoginEntity.self) { response in
                switch response.result {
                case .success(let response) :
                    if response.isSuccess, let result = response.result {
                        viewcontroller.autoLogin = true
                        Constant.JWTToken = UserDefaults.standard.string(forKey: "JWTToken")!
                        Constant.userIdx = result.userIdx
                        Constant.userEmail = result.emailId
                    }
                    else {
                        print("자동 로그인 실패")
                    }
                case .failure(let error):
                    print("자동로그인"+error.localizedDescription)
                }
            }
        }

    }
}
