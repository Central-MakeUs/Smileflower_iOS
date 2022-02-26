//
//  FeedLikeViewModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/25.
//

import Alamofire

class FeedLikdeViewModel {
    func appPicturesSave(_ pictureIdx : Int, completionHandler: @escaping (_ isSuccess : Bool,_ result : String) -> ()) {
        let headers: HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/app/pictures/\(pictureIdx)/save", method: .post, parameters: nil, headers: headers).validate().responseDecodable(of: PictureLikeModel.self) { response in
            switch response.result {
            case .success(let result):
                if let feedresult = result.result {
                    completionHandler(true ,feedresult.result ?? "")
                } else {
                    completionHandler(false, result.message)
                }
            case .failure(let error):
                completionHandler(false, error.localizedDescription)
            }
        }
    }
    
    func appFlagSave(_ flagIdx : Int, completionHandler: @escaping (_ isSuccess : Bool,_ result : String) -> ()) {
        let headers: HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.baseURL + "/app/flags/\(flagIdx)/save", method: .post, parameters: nil, headers: headers).validate().responseDecodable(of: FlagLikeModel.self) { response in
            switch response.result {
            case .success(let result):
                if let feedresult = result.result {
                    completionHandler(true ,feedresult.result ?? "")
                } else {
                    completionHandler(false, result.message)
                }
            case .failure(let error):
                completionHandler(false, error.localizedDescription)
            }
        }
    }
}
