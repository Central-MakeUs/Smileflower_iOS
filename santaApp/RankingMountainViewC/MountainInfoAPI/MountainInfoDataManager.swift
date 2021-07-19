//
//  MountainInfoDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/19.
//

import Alamofire

class MountainInfoDataManager {
    func appmountiansmountainIdxinfo(_ viewcontroller : ContentMountainViewController, _ mountainIdx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.TestURL + "/app/mountains/\(mountainIdx)/info", method: .get, headers: headers).validate().responseDecodable(of: MountainInfoEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    viewcontroller.successDataMountainInfo(result)
                }
            case .failure(let error):
                viewcontroller.faillureDataMountainInfo("네트워크 통신 장애")
            }
        }
    }
}
