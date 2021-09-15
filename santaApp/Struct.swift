//
//  Struc.swift
//  santaApp
//
//  Created by 노영재 on 2021/09/13.
//
import UIKit
enum AppstoreOpenError: Error {
    case invalidAppStoreURL
    case cantOpenAppStoreURL
}

struct Constants {

    struct System {
        static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        static let bundleIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
        static let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        static func latestVersion() -> String? {
            let appleID = "1575356767"
            guard let url = URL(string: "http://itunes.apple.com/lookup?id=\(appleID)"),
                  let data = try? Data(contentsOf: url),
                  let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                  let results = json["results"] as? [[String: Any]],
                  let appStoreVersion = results[0]["version"] as? String else {
                return nil
            }
            return appStoreVersion
        }
        func openAppStore(urlStr: String) -> Result<Void, AppstoreOpenError> {

               guard let url = URL(string: urlStr) else {
                   print("invalid app store url")
                   return .failure(.invalidAppStoreURL)
               }

               if UIApplication.shared.canOpenURL(url) {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
                   return .success(())
               } else {
                   print("can't open app store url")
                   return .failure(.cantOpenAppStoreURL)
               }
           }
    static let appStoreOpenUrlString = "itms-apps://itunes.apple.com/app/apple-store/1575356767" // 1548711244는 Apple ID
    }
}
