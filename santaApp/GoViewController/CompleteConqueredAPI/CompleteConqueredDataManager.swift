//
//  CompleteConqueredDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/18.
//

import Alamofire

class CompleteConqueredDataManager {
    func appflagsmountainIdxrank(_ viewcontroller : CompleteViewController, _ mountainIdx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/app/flags/\(mountainIdx)/rank", method: .get, headers: headers).validate().responseDecodable(of: CompleteConqueredEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    viewcontroller.successDataResult(result)
                }
            case .failure(let error):
                viewcontroller.failureDataResutl()
            }
        }
    }
}
