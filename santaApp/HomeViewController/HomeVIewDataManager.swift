//
//  HomeVIewDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/13.
//

import Alamofire

class HomeViewDataManager {
    func apphomes(viewcontroller : HomeViewController) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.TestURL + "/app/homes" , method: .get,headers: headers).validate().responseDecodable(of: HomeViewEntity.self) { response in
            switch response.result {
            case .success(let response) :
                if response.isSuccess, let result = response.result {
                    viewcontroller.successDataReceive(result)
                }
            case .failure(let error) :
                print(error.localizedDescription)
                viewcontroller.failureDataReceive("네트워크 통신 장애")
            }
        }
    }
}
