//
//  GoViewControllerDataManager.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/13.
//

import Alamofire

class GoViewControllerDataManager {
    func appflagsmountain(_ viewcontroller : GoViewController, _ ) {
        let headers : HTTPHeaders = [ "X-ACCESS-TOKEN" : Constant.JWTToken ]
        AF.request(Constant.TestURL + "/app/flags", method: <#T##HTTPMethod#>, parameters: <#T##Encodable?#>, encoder: <#T##ParameterEncoder#>, headers: <#T##HTTPHeaders?#>, interceptor: <#T##RequestInterceptor?#>, requestModifier: <#T##Session.RequestModifier?##Session.RequestModifier?##(inout URLRequest) throws -> Void#>)
    }
}
