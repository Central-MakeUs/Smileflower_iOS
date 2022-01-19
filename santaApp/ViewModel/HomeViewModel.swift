//
//  HomeViewModel.swift
//  santaApp
//
//  Created by 노영재 on 2022/01/05.
//

import Alamofire

class HomeViewModel {
    let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
    func appNewHomeAPI(completionHandler: @escaping (_ result: Array<HomeModelPictureList>, Array<HomeModelUserList>, Array<HomeModelMountainsList>) -> ()) {
        AF.request(Constant.baseURL + "/app/new-homes", method: .get, parameters: nil, headers: headers).validate().responseDecodable(of: HomeModel.self) { response in
            switch response.result {
            case .success(let result):
                var arrayPicture : [HomeModelPictureList] = []
                var arrayUser : [HomeModelUserList] = []
                var arrayMountain : [HomeModelMountainsList] = []
                
                if result.isSuccess ,let result = result.result {
                    arrayPicture = result.getFlagResList ?? []
                    arrayMountain = result.getMountainsResList ?? []
                    arrayUser = result.getUsersResList ?? []
                    completionHandler(arrayPicture, arrayUser, arrayMountain)
                } else {
                    completionHandler(arrayPicture, arrayUser, arrayMountain)
                }
            case .failure(let error):
                print(error.errorDescription)
                completionHandler([], [], [])
            }
        }
    }
    
    
}
