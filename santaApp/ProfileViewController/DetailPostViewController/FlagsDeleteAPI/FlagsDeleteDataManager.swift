//
//  PostsDeleteDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/22.
//

import Alamofire

class FlagsDeleteDataManager {
    func apiprofileuseridxflagsflagIdx( _ flagIdx :Int, _ cell : DetailPostCollectionViewCell) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/app/flags/\(flagIdx)", method: .delete, headers: headers).validate().responseDecodable(of: FlagsDeleteEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.issuccess {
                    cell.successDataApiDeletePosts()
                }
            case .failure(let error):
                cell.failureDataApiDelete(error.localizedDescription)
            }
        }
    }
}
