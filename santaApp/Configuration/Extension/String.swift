//
//  String.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
    func toPngString() -> String? {
        let data = self.pngData
            return data?.base64EncodedString(options: .endLineWithLineFeed)
        }
}
