//
//  ChangeNicnameDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/21.
//

import Alamofire

class ChangeNicnameDataManager {
    func appUsersNicknameIdx(_ viewcontroller : ChangeNicnameViewController, _ parameters : ChangeNicknameInput, _ userIdx : Int) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken]
        print(parameters)
        print(userIdx)
        AF.request(Constant.baseURL + "/app/users/nickname/\(userIdx)", method: .patch, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).validate().responseDecodable(of: ChangeNicnameModel.self) { response in
            switch response.result {
            case .success(let result):
                viewcontroller.succeesChangeNickname(result)
            case .failure(let error):
                viewcontroller.failureDataApi("닉네임 변경 오류:\(error.localizedDescription)")
            }
        }
    }
}
