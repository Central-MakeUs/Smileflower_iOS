//
//  CommentDeleteViewModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/17.
//

import Alamofire

class CommentDeleteViewModel {
    func appCommentsIdxType(_ idx : Int, _ type : String ,completionHandler: @escaping (_ result : String) -> ()) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken]
        AF.request(Constant.baseURL + "/app/comments/\(idx)?type=\(type)", method: .patch, headers: headers).validate().responseDecodable(of: CommentDeleteModel.self) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result.message)
            case .failure(let error):
                completionHandler(error.localizedDescription)
            }
        }
    }
}
