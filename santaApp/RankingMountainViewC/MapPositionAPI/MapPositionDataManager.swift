//
//  MapPositionDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/18.
//

import Alamofire

class MapPositionDataManager {
    func appmountainsmountainIdxmap(_ viewcontroller : RankingMountainViewController, _ mountainIdx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/app/mountains/\(mountainIdx)/map", method: .get,headers: headers).validate().responseDecodable(of: MapPositionEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result{
                    viewcontroller.successDataMountainPosition(result)
                }
            case .failure(let error):
                viewcontroller.failureDataMountainPosition()
            }
        }
    }
}
