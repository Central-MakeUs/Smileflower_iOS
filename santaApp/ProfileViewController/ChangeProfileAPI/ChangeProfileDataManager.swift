//
//  ChangeProfileDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

import Alamofire

class ChangeProfileDataManager {
    func apiprofileupload(_ imageUser : Data, _ viewcontroller : ProfileViewController) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(imageUser, withName: "file", fileName: "a.jpg", mimeType: "image/jpg")
        }, to: Constant.baseURL + "/app/profiles/profile-img", method: .patch ,headers: headers).responseDecodable(of: ChangeProfileEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    viewcontroller.successDataApiChangeProfileImage()
                }
                else {
                    viewcontroller.presentAlert(title: response.message)
                }
            case .failure(let error):
                viewcontroller.presentAlert(title: error.localizedDescription)
            }
        }
    }
}
