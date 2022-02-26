//
//  CommentsDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/21.
//

import Alamofire

class CommentsDataManager {
    func commentsDataManager(_ viewController : DetailMessageViewController, _ parameters : inputComments, _ idx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/app/comments/\(idx)", method: .get, parameters: parameters, headers: headers).validate().responseDecodable(of: CommentsModel.self) { response in
            switch response.result {
            case .success(let result):
                print("성공")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
