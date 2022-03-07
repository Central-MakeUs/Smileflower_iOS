//
//  GoViewControllerDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/13.
//

import Alamofire

class CheckMountainDataManager {
    func appflagsmountain(_ viewcontroller : InputMountainNameViewController, _ mountainName : String) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        let parameters : Parameters = [ "mountain" : mountainName]
        AF.request(Constant.baseURL + "/app/flags", method: .get, parameters: parameters, headers: headers).validate().responseDecodable(of: GoViewControllerEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result{
                    viewcontroller.successDataMountain(result)
                }
                else {
                    viewcontroller.faillureDataApi(response.message)
                }
                print(response.message)
            case .failure(let errror) :
                viewcontroller.faillureDataApi("네트워크가 연결되어 있지 않습니다.")
            }
        }
    }
}
