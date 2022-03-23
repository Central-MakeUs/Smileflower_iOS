//
//  LogoutDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/16.
//

import Alamofire

class LogoutDataManager {
    func appuserslogout(_ viewcontroller : SetupViewController) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/app/users/logout", method: .patch, headers: headers).validate().responseDecodable(of: LogoutEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    Constant.JWTToken = ""
                    UserDefaults.standard.set("", forKey: "JWTToken")
                    print(response.message)
                }
                else {
                    print(response.message + "1")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
