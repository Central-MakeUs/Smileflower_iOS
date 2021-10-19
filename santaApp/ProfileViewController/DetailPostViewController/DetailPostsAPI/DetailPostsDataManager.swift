//
//  DetailPostsDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

import Alamofire

class DetailPostsDataManager {
    func apiprofileuserIdxposts(_ viewcontroller : DetailPosteViewController, _ userIdx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/api/profile/\(userIdx)/posts", method: .get, headers: headers).validate().responseDecodable(of: DetailPostsEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.success, let result = response.response {
                    viewcontroller.successDataApiPosts(result)
                }
            case .failure(let error):
                viewcontroller.failureDataApiPosts("네트워크 통신 장애")
            }
        }
    }
}
