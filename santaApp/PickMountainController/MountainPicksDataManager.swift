//
//  MountainPicksDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/17.
//

import Alamofire

class MountainPicksDataManager {
    func apppicks(_ viewcontroller : PickMountainViewController) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.TestURL + "/app/picks", method: .get, headers: headers).validate().responseDecodable(of: MountainPicksEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    viewcontroller.successDataPick(result)
                }
            case .failure(let error):
                viewcontroller.failureDataPick()
            }
        }
    }
}
