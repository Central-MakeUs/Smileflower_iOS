//
//  ShowUserResultDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/22.
//

import Alamofire

class ShowUserResultDataManager {
    func apiprofileuserIdxresult(_ viewcontroller : ProfileViewController, _ userIdx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/api/profile/\(userIdx)/result", method: .get, headers: headers).validate().responseDecodable(of: ShowUserResutlEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.success, let result = response.response {
                    viewcontroller.successDataApiUserResult(result)
                }
            case .failure(let error):
                viewcontroller.faillureDataApi("네트워크 통신 장애")
                print("성과뷰\(error.localizedDescription)")
            }
        }
    }
}
