//
//  AlertViewModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/10.
//

import Alamofire

class AlertViewModel {
    func appNewHomesNotification(completionHandler: @escaping (_ result: [AlertResult]) -> ()) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken]
        AF.request(Constant.baseURL + "/app/new-homes/notification", method: .get, headers: headers).validate().responseDecodable(of: AlertModel.self) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result.result ?? [])
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler([])
            }
        }
    }
    
    func appNewHomesNotificationIdx(_ idx : Int,completionHandler: @escaping (_ result: String) -> ()) {
        let headers : HTTPHeaders = ["X-ACCESS-TOKEN" : Constant.JWTToken]
        AF.request(Constant.baseURL + "/app/new-homes/notification/\(idx)", method: .patch, parameters: nil, headers: headers).validate().responseDecodable(of: AgreeModel.self) { response in
            switch response.result {
            case .success(let result):
                print(result.message)
                completionHandler(result.message)
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler("")
            }
        }
    }
}
