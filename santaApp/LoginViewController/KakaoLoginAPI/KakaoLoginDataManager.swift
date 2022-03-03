//
//  KakaoLoginDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/26.
//

import Alamofire

class KaKaoLoginDataManager {
    func appKakaoLogin( _ viewController : LoginViewController, _ input : KakaoLoginInput) {
        AF.request(Constant.baseURL + "/app/kakao-login", method: .post, parameters: input, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: KakaoLoginModel.self) { response in
            switch response.result {
            case .success(let result):
                if let result = result.result {
                    viewController.successKakaoLogin(result)
                }
            case .failure(let error):
                print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
                print(error.localizedDescription)
            }
        }
    }
}
