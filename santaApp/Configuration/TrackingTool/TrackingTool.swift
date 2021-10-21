//
//  TrackingTool.swift
//  fit-ble
//
//  Created by sam on 2021/09/06.
//  Copyright © 2021 fitmedi. All rights reserved.
//

import Foundation
import FirebaseAnalytics

class TrackingTool: NSObject {
    
    static func Screen(screenName: String) -> () {
        Analytics.logEvent(AnalyticsEventScreenView,
                           parameters: [AnalyticsParameterScreenName: screenName])
    }
    
    static func Action(actionName: String, param: [String:String]) -> () {
        Analytics.logEvent(actionName, parameters: param)
    }
}
