//
//  CommentsDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/21.
//

import Alamofire

class CommentsViewModel {
    func appCommentsIdx(_ parameters: inputComments, _ idx : Int ,completionHandler: @escaping (_ result: CommentsModel, _ arrayBool: [Bool]) -> ()) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        var arrayBool : [Bool] = []
        AF.request(Constant.baseURL + "/app/comments/\(idx)", method: .get, parameters: parameters, headers: headers).validate().responseDecodable(of: CommentsModel.self) { response in
            switch response.result {
            case .success(let result):
                if let count = result.result {
                    for i in 0...count.count {
                        arrayBool.append(false)
                    }
                }

                completionHandler(result, arrayBool)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
