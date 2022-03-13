//
//  AgreeViewModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/14.
//

import Alamofire

class AgreeViewModel {
    func appUsersAgree(completionHandler: @escaping (_ result: String) -> ()) {
        let headers : HTTPHeaders = ["X-ACCESS-TOKEN" : Constant.JWTToken]
        AF.request(Constant.baseURL + "/app/users/agree", method: .patch, parameters: nil, headers: headers).validate().responseDecodable(of: AgreeModel.self) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result.message)
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler("")
            }
        }
    }
}
