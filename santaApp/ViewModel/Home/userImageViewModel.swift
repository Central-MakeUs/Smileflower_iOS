//
//  userImageViewModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/03.
//

import Alamofire

class userimageViewModel {
    func appCommentsUserImage(completionHandler: @escaping (_ result: userImageResult) -> ()) {
        let header : HTTPHeaders = ["X-ACCESS-TOKEN" : Constant.JWTToken]
        AF.request(Constant.baseURL + "/app/comments/user-image", method: .get, headers: header).validate().responseDecodable(of: userImageModel.self) { response in
            switch response.result {
            case .success(let result):
                if let result = result.result {
                    completionHandler(result)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
