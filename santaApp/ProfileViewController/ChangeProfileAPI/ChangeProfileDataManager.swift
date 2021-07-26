//
//  ChangeProfileDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/21.
//

import Alamofire

class ChangeProfileDataManager {
    func apiprofileupload(_ imageUser : Data, _ viewcontroller : UIViewController) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(imageUser, withName: "file", fileName: "a.jpg", mimeType: "image/jpg")
        }, to: Constant.baseURL + "/api/profile/upload", method: .patch ,headers: headers).responseDecodable(of: EndViewControllerEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.success {
                    viewcontroller.presentAlert(title: "유저 프로필 변경 성공")
                }
                else {
                    viewcontroller.presentAlert(title: response.error!.message!)
                }
            case .failure(let error):
                viewcontroller.presentAlert(title: "네트워크 통신 장애")
            }
        }
    }
}
