//
//  MountainDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/16.
//

import Alamofire

class MountainDataManager {
    func appmountains(_ viewcontroller : SearchViewController) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.TestURL + "/app/mountains", method: .get, headers: headers).validate().responseDecodable(of: MountainEntity.self) { response in
            switch response.result {
            case .success(let response) :
                if response.isSuccess, let result = response.result {
                    viewcontroller.successDataMountain(result)
                }
            case .failure(let error):
                viewcontroller.failDataMountain()
            }
        }
    }
}
