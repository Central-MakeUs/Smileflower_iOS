//
//  AppleLoginDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/26.
//

import Alamofire

class AppleLoginDataManager {
    func appNewApple(_ viewController : LoginViewController, _ input : AppleLoginInput) {
        AF.request(Constant.baseURL + "/app/new-apple", method: .post, parameters: input, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: AppleLoginModel.self) { response in
            switch response.result {
            case .success(let result):
                print(result.message)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
