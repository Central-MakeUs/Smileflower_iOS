//
//  PostsDeleteDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/22.
//

import Alamofire

class PostsDeleteDataManager {
    func apiprofileuseridxpicturespictures(_ pictureIdx :Int, _ cell : DetailMyPostCollectionViewCell) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/app/pictures/\(pictureIdx)", method: .delete, headers: headers).validate().responseDecodable(of: PostsDeleteEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    cell.successDataApiDeletePosts()
                }
            case .failure(let error):
                cell.failureDataApiDelete(error.localizedDescription)
            }
        }
    }
}
