//
//  UIImage.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/30.
//

import UIKit
import Accelerate

extension UIImage {

    func aspectFitImage(inRect rect: CGRect) -> UIImage? {
        let width = self.size.width
        let height = self.size.height
        let aspectWidth = rect.width / width
        let aspectHeight = rect.height / height
        let scaleFactor = aspectWidth > aspectHeight ? rect.size.height / height : rect.size.width / width

        UIGraphicsBeginImageContextWithOptions(CGSize(width: width * scaleFactor, height: height * scaleFactor), false, 0.0)
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: width * scaleFactor, height: height * scaleFactor))

        defer {
            UIGraphicsEndImageContext()
        }

        return UIGraphicsGetImageFromCurrentImageContext()
    }
    //MARK: 이미지 투명도
    func image(alpha: CGFloat) -> UIImage? {
           UIGraphicsBeginImageContextWithOptions(size, false, scale)
           draw(at: .zero, blendMode: .normal, alpha: alpha)
           let newImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return newImage
    }
}
