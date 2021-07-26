//
//  SignInViewControllerDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

import Alamofire

class SignInViewControllerDataManager {
    func appuserslogin(_ viewcontroller : SignInViewController, _ parameters : SignInViewControllerInput) {
        AF.request(Constant.baseURL + "/app/users/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: SignInViewControllerEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    viewcontroller.successLoginData(result)
                }
                else {
                    viewcontroller.successDataButError(response)
                }
            case .failure(let error):
                viewcontroller.failureDataApi()
            }
        }
    }
}
