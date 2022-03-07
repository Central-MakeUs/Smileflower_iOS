//
//  ReCommentViewModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/03.
//

import Alamofire

class ReCommentViewModel {
    func appCommentsRecommentIdxType(_ parameters: inputWriteDoubleComment, _ idx : Int, _ type : String ,completionHandler: @escaping (_ result: WriteDoubleCommentResult) -> ()) {
        let header : HTTPHeaders = ["X-ACCESS-TOKEN" : Constant.JWTToken]
        AF.request(Constant.baseURL + "/app/comments/recomment/\(idx)?type=\(type)", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: header).validate().responseDecodable(of: WriteDoubleCommentModel.self) { response in
            switch response.result {
            case .success(let result):
                if let result = result.result {
                    completionHandler(result)
                } else {
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
