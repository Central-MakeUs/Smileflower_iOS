//
//  CertificationNumberDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/24.
//

import Alamofire

class CertificationNumberDataManager {
    func appemilverify(_ viewcontroller : CheckNumberViewController, _ parameters : CertificationNumberInput) {
        AF.request(Constant.baseURL + "/app/email/verify", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: CertificationNumberEntity.self) { response in
            switch response.result {
            case .success(let response ):
                if response.isSuccess {
                    viewcontroller.successDataApiCertification("인증이 완료되었습니다.")
                }
                else {
                    viewcontroller.failureDataApiCeritfication(response.message)
                }
            case .failure(let error):
                viewcontroller.failureDataApiCeritfication("네트워크 통신 장애")
            }
        }
    }
}
