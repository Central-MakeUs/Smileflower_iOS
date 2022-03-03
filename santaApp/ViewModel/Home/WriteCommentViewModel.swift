//
//  WriteCommentViewModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/03.
//

import Alamofire

class writeCommentViewModel {
    func appCommentsIdxType(_ parameters: inputWriteComment, _ idx : Int, _ type : String ,completionHandler: @escaping (_ result: writeCommentModel) -> ()) {
        let headers : HTTPHeaders = ["X-ACCESS-TOKEN" : Constant.JWTToken]
        AF.request(Constant.baseURL + "/app/comments/\(idx)?type=\(type)", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).validate().responseDecodable(of: writeCommentModel.self) { response in
            switch response.result {
            case .success(let response):
                completionHandler(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
