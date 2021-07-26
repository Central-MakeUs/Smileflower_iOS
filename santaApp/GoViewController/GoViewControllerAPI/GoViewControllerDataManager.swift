//
//  GoViewControllerDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/13.
//

import Alamofire

class GoViewControllerDataManager {
    func appflagsmountain(_ viewcontroller : GoViewController, _ mountainName : String) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        let parameters : Parameters = [ "mountain" : mountainName]
        AF.request(Constant.baseURL + "/app/flags", method: .get, parameters: parameters, headers: headers).validate().responseDecodable(of: GoViewControllerEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result{
                    viewcontroller.successDataMountain(result)
                    print("성공")
                }
                else {
                    viewcontroller.failureNoDataMountain(response.message)
                    print("왜그래?")
                }
            case .failure(let errror) :
                viewcontroller.failureNoDataMountain("네트워크가 연결되어 있지 않습니다.")
            }
        }
    }
}
