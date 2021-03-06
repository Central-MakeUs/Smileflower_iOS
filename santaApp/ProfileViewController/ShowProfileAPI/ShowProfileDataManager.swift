//
//  ShowProfileDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/20.
//

import Alamofire

class ShowProfileDataManager {
    func apiprofileuserIdx(_ viewcontroller : ProfileViewController, _ userIdx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/app/profiles", method: .get, headers: headers).validate().responseDecodable(of: ShowProfileEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    viewcontroller.successDataApiShowProfile(result)
                } else {
                    print(response.message)
                }
            case .failure(let error):
                viewcontroller.faillureDataApi("네트워크 통신 장애")
            }
        }
    }
}
