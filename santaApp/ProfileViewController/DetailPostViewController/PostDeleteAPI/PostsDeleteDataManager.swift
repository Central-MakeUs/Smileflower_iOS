//
//  PostsDeleteDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/22.
//

import Alamofire

class PostsDeleteDataManager {
    func apiprofileuseridxpicturespictures(_ userIdx : Int, _ pictureIdx :Int, _ cell : DetailPostCollectionViewCell) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/api/profile/\(userIdx)/pictures/\(pictureIdx)", method: .delete, headers: headers).validate().responseDecodable(of: PostsDeleteEntity.self) { response in
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
