//
//  RegisterImageDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

import Alamofire

class RegisterImageDataManager {
    func apiprofilepicture(_ dataimage : Data, _ viewcontroller : ProfileViewController) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(dataimage, withName: "file", fileName: "a.jpg", mimeType: "image/jpg")
        }, to: Constant.TestURL + "/api/profile/picture", method: .post ,headers: headers).responseDecodable(of: RegisterImageEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.success {
                    viewcontroller.successDataApiRegisterImage()
                }
                else {
                    viewcontroller.faillureDataApi(response.error!.message!)
                }
            case .failure(let error):
                viewcontroller.faillureDataApi("네트워크 통신 장애")
            }
        }
    }
}
