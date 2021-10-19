//
//  FlagMountainDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/23.
//

import Alamofire

class FlagMountainDataManager {
    func apiprofileuserIdxflagsmap(_ viewcontroller : FlagMapViewController, _ userIdx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/api/profile/\(userIdx)/flags/map", method: .get, headers: headers).validate().responseDecodable(of: FlagMountainEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.success, let result = response.response {
                    viewcontroller.successDataApi(result)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
