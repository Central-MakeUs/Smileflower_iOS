//
//  RemoteConfigManager.swift
//  fit-ble
//
//  Created by sam on 2021/03/05.
//  Copyright © 2021 fitmedi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseRemoteConfig

class AppConfig {
    var lastestVersion: String?
    var minVersion: String?
    var isUpdateOnAppsotre: Bool?
    var IntroDateConfig: String?
}

class RemoteConfigManager: NSObject {
    
    static let sharedManager = RemoteConfigManager()
    override private init() {}
    
    public func launching(completionHandler: @escaping (_ conf: AppConfig) -> (), forceUpdate:@escaping (_ need: Bool)->()) {
        let remoteConfig = RemoteConfig.remoteConfig()
        
        remoteConfig.fetch(withExpirationDuration: TimeInterval(3600)) { (status, error) -> Void in
            if status == .success {
                remoteConfig.activate { (Bool, error) in
                    //
                }
                
                // 데이터 Fetch
                let appConfig: AppConfig = AppConfig()
                UserDefaults.standard.set(remoteConfig["IntroDateConfig"].stringValue as! String, forKey: "IntroDateRemote")//인트로 기준날짜
                UserDefaults.standard.synchronize()
                
                appConfig.isUpdateOnAppsotre = remoteConfig["updateOnAppstore"].boolValue as! Bool//앱스토어 올라가고 나서만 강업팝업뜨게만들어놓음
                if appConfig.isUpdateOnAppsotre == true {
                    
                    appConfig.lastestVersion = remoteConfig["version"].stringValue as! String
                    UserDefaults.standard.set(appConfig.lastestVersion, forKey: "AppRetestVersion")//최신버전 저장
                    UserDefaults.standard.synchronize()
                    
                    completionHandler(appConfig)
                    
                    //현재앱버전
                    let nowAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                    // 강제업데이트
                    let needForcedUpdate:Bool = !(appConfig.lastestVersion == nowAppVersion)
                    forceUpdate(needForcedUpdate)
                    if needForcedUpdate {
                        let alertController = UIAlertController.init(title: "업데이트", message: "필수 업데이트가 있습니다. 업데이트하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
                        alertController.addAction(UIAlertAction.init(title: "업데이트", style: UIAlertAction.Style.default, handler: { (action) in
                            // 앱스토어이동
                            if let url = URL(string: "itms-apps://itunes.apple.com/app/1575356767"), UIApplication.shared.canOpenURL(url) {
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                } else {
                                    UIApplication.shared.openURL(url)
                                }
                            }
                        }))
                        var topController = UIApplication.shared.keyWindow?.rootViewController
                        if topController != nil {
                            while let presentedViewController = topController?.presentedViewController {
                                topController = presentedViewController
                            }
                        }
                        topController!.present(alertController, animated: false, completion: {
                            
                        })
                    }
                    
                } else {
                    forceUpdate(false)//앱스토어에 안올라갔으니까 강업아직 안띄움(업데이트할게없으니까)
                }
            }
        }
    }
    
    //마이너 업데이트 (수동업데이트용으로 남겨놓음)>>안쓰면 없애면됌
    private func compareVersion(versionA:String!, versionB:String!) -> ComparisonResult {
        let majorA = Int(Array(versionA.split(separator: "."))[0])!
        let majorB = Int(Array(versionB.split(separator: "."))[0])!
        
        if majorA > majorB {
            return ComparisonResult.orderedDescending
        } else if majorB > majorA {
            return ComparisonResult.orderedAscending
        }
        
        let minorA = Int(Array(versionA.split(separator: "."))[1])!
        let minorB = Int(Array(versionB.split(separator: "."))[1])!
        if minorA > minorB {
            return ComparisonResult.orderedDescending
        } else if minorB > minorA {
            return ComparisonResult.orderedAscending
        }
        return ComparisonResult.orderedSame
    }
    
}
