//
//  CheckEmailDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/24.
//

import Alamofire

class CheckEmailDataManager {
    func appemailcode(_ viewcontroller : SignUpViewController, _ parameters : CheckEmailInput) {
        AF.request(Constant.TestURL + "/app/email/code", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: CheckEmailEntity.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    viewcontroller.successDataApiCheckImailPost("인증번호를 입력해주세요.")
                }
                else {
                    viewcontroller.failureDataApi(response.message)
                }
            case .failure(let error) :
                viewcontroller.failureDataApi("네트워크 통신 장애")
            }
        }
    }
}
