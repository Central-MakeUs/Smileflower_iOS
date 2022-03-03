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
        }, to: Constant.baseURL + "/app/profiles/picture", method: .post ,headers: headers).responseDecodable(of: RegisterImageEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    viewcontroller.successDataApiRegisterImage()
                }
                else {
                    viewcontroller.faillureDataApi(response.message)
                }
            case .failure(let error):
                print("등록된사진\(error.localizedDescription)")
                viewcontroller.faillureDataApi(error.localizedDescription)
            }
        }
    }
}
