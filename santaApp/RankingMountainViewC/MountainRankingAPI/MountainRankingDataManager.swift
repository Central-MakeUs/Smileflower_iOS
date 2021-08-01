//
//  MountainRankingDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/19.
//

import Alamofire

class MountainRankingDataManager {
    func appmountainsmountainIdxrank(_ viewcontroller : ContentRankViewController, _ mountainIdx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/app/mountains/\(mountainIdx)/rank", method: .get, headers: headers).validate().responseDecodable(of: MountainRankingEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess , let result = response.result {
                    viewcontroller.SuccessDataMountainRanking(result)
                }
            case .failure(let error):
                viewcontroller.failureDataMountainRanking("네트워크 통신 장애")
                print("랭킹"+error.localizedDescription)
            }
        }
    }
}
