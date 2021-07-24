//
//  ForgetPasswordDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/24.
//

import Alamofire

class ForgetPasswordDataManager {
    func appemailspassword(_ viewcontroller : ForgetPasswordViewController, _ parameters : ForgetPasswordInput) {
        AF.request(Constant.TestURL + "/app/email/password", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: ForgetPasswordEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    viewcontroller.successDataApiForgetPassword("비밀번호를 이메일로 발송했습니다.")
                }
                    else {
                        viewcontroller.failureDataApi(response.message)
                    }
            case .failure(let error):
                viewcontroller.failureDataApi("네트워크 연결 장애")
                print(error.localizedDescription)
            }
        }
    }
}
