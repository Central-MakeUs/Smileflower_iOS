//
//  ShowProfileDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/20.
//

import Alamofire

class ShowProfileDataManager {
    func apiprofileuserIdx(_ viewcontroller : ProfileViewController, _ userIdx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.TestURL + "/api/profile/\(userIdx)", method: .get, headers: headers).validate().responseDecodable(of: ShowProfileEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.success, let result = response.response {
                    print("프로필 뷰 성공")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
