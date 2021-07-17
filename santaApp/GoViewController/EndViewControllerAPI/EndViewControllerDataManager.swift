//
//  EndViewControllerDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

import Alamofire

class EndViewControllerDataManager {
    func appflagsmountainIdx(_ viewcontroller : EndViewController, _ parameters : EndViewControllerInput, _ mountainIdx : Int, _ dataimg : Data) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(dataimg, withName: "images", fileName: "a.jpg", mimeType: "image/jpg")
        }, to: Constant.TestURL + "/images", headers: headers).validate().responseDecodable(of: EndViewControllerEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("성공")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
