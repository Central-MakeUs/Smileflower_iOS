//
//  MountainLikeDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/17.
//

import Alamofire

class MountainLikeDataManager {
    func apppicksmountainIdx(_ mountainIdx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        
        AF.request(Constant.TestURL + "/app/picks/\(mountainIdx)", method: .patch, headers: headers).validate().responseDecodable(of: MountainLikeEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    print(result.result)
                }
            case .failure(let errorr):
                print(errorr.localizedDescription)
            }
        }
    }
}
