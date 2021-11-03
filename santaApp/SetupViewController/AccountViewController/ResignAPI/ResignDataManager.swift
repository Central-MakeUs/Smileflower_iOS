//
//  ResignDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/11/04.
//

import Alamofire

class ResignDataManager {
    func appuserslogout(_ viewcontroller : AccountViewController, userIdx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/app/users/\(userIdx)", method: .delete, headers: headers).validate().responseDecodable(of: LogoutEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    print(response.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
