//
//  PostsDeleteDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/22.
//

import Alamofire

class FlagsDeleteDataManager {
    func apiprofileuseridxflagsflagIdx(_ userIdx : Int, _ flagIdx :Int, _ cell : DetailPostCollectionViewCell) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.TestURL + "/api/profile/\(userIdx)/flags/\(flagIdx)", method: .delete, headers: headers).validate().responseDecodable(of: FlagsDeleteEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.success {
                    cell.successDataApiDeletePosts()
                }
            case .failure(let error):
                cell.failureDataApiDelete("네트워크 통신 장애")
            }
        }
    }
}
