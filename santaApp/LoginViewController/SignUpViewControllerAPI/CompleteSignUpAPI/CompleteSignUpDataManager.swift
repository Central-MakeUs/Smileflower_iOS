//
//  CompleteSignUpDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

import Alamofire

class CompleteSignUpDataManager {
    func appusers(_ viewcontroller : SignUpViewController, _ parameters : CompleteSignUpInput){
        AF.request(Constant.baseURL + "/app/users", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: CompleteSignUpEntity.self) { response in
            switch response.result {
            case .success(let response):
                print(response.message)
                if response.isSuccess, let result = response.result {
                    viewcontroller.successDataAndCompleteApi(result)
                }
                else {
                    viewcontroller.successDataButDontCompleteApi(response)
                }
            case .failure(let error) :
                viewcontroller.failureDataApi("네트워크 통신 장애")
            }
        }
    }
}
