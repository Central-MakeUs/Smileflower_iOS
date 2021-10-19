//
//  MountainSearchDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/19.
//

import Alamofire

class MountainSearchDataManager {
    func appmountainssearchmountain(_ viewcontroller : SearchViewController, _ parameters : MountainSearchInput) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/app/mountains/search", method: .get, parameters: parameters, headers: headers).validate().responseDecodable(of: MountainSearchEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    viewcontroller.successDataMountainSearch(result)
                }
                else {
                    viewcontroller.failDataMountain(response.message)
                }
            case .failure(let error):
                viewcontroller.failDataMountain("네트워크 통신 장애")
            }
        }
    }
}
