//
//  EndViewControllerDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

import Alamofire

class EndViewControllerDataManager {
    func appflagsmountainIdx(_ viewcontroller : EndViewController, _ mountainIdx : Int, _ dataimg : Data) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(dataimg, withName: "file", fileName: "a.jpg", mimeType: "image/jpg")
        }, to: Constant.TestURL + "/api/flag/upload/\(mountainIdx)", method: .post ,headers: headers).responseDecodable(of: EndViewControllerEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.success {
                    print("성공")
                }
                else {
                    print(response.error!.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
            
        }
}
