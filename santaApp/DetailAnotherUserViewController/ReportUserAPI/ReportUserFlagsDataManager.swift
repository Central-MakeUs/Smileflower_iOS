//
//  ReportUserFlagsDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/22.
//

import Alamofire

class ReportUserFlagsDataManager {
    func apiprofileuserIdxflagsflagIdxreport(_ userIdx : Int, _ flagIdx : Int, _ cell : DetailAnotherUserCollectionViewCell) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.TestURL + "/api/profile/\(userIdx)/flags/\(flagIdx)/report", method: .post, headers: headers).validate().responseDecodable(of: ReportUserFlagsEntity.self) { response in
            switch response.result {
            case .success(let response) :
                if response.success {
                    cell.successDataApiReport()
                }
            case .failure(let error) :
                cell.failuerDataApi("네트워크 통신 장애")
            }
        }
    }
}
