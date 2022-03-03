//
//  ConquerViewModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/26.
//

import Alamofire

class ConquerViewModel {
    func appnewHomesflags(completionHandler: @escaping (_ result: Array<ConquerResult>) -> ()) {
        let headers : HTTPHeaders = ["X-ACCESS-TOKEN" : Constant.JWTToken]
        AF.request(Constant.baseURL + "/app/new-homes/flags", method: .get, parameters: nil, headers: headers).validate().responseDecodable(of: ConquerModel.self) { response in
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
