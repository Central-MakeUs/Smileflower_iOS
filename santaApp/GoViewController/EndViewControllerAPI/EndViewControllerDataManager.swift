//
//  EndViewControllerDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

import Alamofire

class EndViewControllerDataManager {
    func appflagsmountainIdx(_ viewcontroller : EndViewController, _ mountainIdx : Int, _ dataimg : Data, _ lat : Double, _ long : Double, _ alt : Double ) {
        let headers : HTTPHeaders = ["X-ACCESS-TOKEN" : Constant.JWTToken ,"Content-Type": "multipart/form-data"]
        
        
        let parameters = [
            "latitude" : lat,
            "longitude" : long,
            "altitude" : alt
        ]

        AF.upload(multipartFormData: { MultipartFormData in
            for (key, value) in parameters {
                print(key)
                print(value)
                MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "application/json") }
            MultipartFormData.append(dataimg, withName: "file", fileName: "a.jpg", mimeType: "multipart/form-data")
        }, to: Constant.baseURL + "/api/flag/\(mountainIdx)", method: .post ,headers: headers).responseDecodable(of: EndViewControllerEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.success {

                    viewcontroller.successDataImageRegister()
                }
                else {
                    viewcontroller.failureDataImageRegister(response.error!.message!)
                }
            case .failure(let error):
                print(error.localizedDescription)
                viewcontroller.failureDataImageRegister("네트워크 통신 장애")
            }
        }
            
        }
}
