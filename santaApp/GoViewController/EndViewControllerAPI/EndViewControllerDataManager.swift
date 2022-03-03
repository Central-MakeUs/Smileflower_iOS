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
                MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "application/json") }
            MultipartFormData.append(dataimg, withName: "file", fileName: "a.jpg", mimeType: "multipart/form-data")
        }, to: Constant.baseURL + "/app/flag/\(mountainIdx)", method: .post ,headers: headers).responseDecodable(of: EndViewControllerEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result{
                    if result.doubleVisited {
                        viewcontroller.failureDataImageRegister("하루에 두 번 인증은 불가능합니다!")

                    } else {
                        viewcontroller.successDataImageRegister()
                    }
                }
                else if !response.isSuccess{
                    viewcontroller.failureDataImageRegister(response.message)
                }
                else {
                    viewcontroller.failureDataImageRegister(response.message ?? "")
                }
            case .failure(let error):
                viewcontroller.failureDataImageRegister(error.localizedDescription)
            }
        }
            
        }
}
