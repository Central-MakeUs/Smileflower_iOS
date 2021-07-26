//
//  CheckNicnameDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

import Alamofire

class CheckNicnameDataManager {
    func appUsersNameCheck(_ viewcontroller : SignUpViewController, _ parameters : CheckNicnameInput) {
        AF.request(Constant.baseURL + "/app/users/name-check", method: .post, parameters: parameters,encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: CheckNicnameEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    viewcontroller.successDataCheckApi(result)
                }
            case .failure(let error):
                viewcontroller.failureDataApi("네트워크 통신 장애")
            }
        }
    }
}
