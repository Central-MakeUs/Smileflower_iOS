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
    
    func resize(size: CGSize) -> UIImage? {
            
            guard let cgImage = self.cgImage else { return nil}
            
            var format = vImage_CGImageFormat(bitsPerComponent: 8, bitsPerPixel: 32, colorSpace: nil,
                                              bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue),
                                              version: 0, decode: nil, renderingIntent: CGColorRenderingIntent.defaultIntent)
            var sourceBuffer = vImage_Buffer()
            defer {
                if #available(iOS 13.0, *) {
                    sourceBuffer.free()
                } else {
                    sourceBuffer.data.deallocate()
                }
            }
            
            var error = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, cgImage, numericCast(kvImageNoFlags))
            guard error == kvImageNoError else { return nil }
            
            // create a destination buffer
            let scale = self.scale
            let destWidth = Int(size.width)
            let destHeight = Int(size.height)
            let bytesPerPixel = cgImage.bitsPerPixel / 8
            let destBytesPerRow = destWidth * bytesPerPixel
            let destData = UnsafeMutablePointer<UInt8>.allocate(capacity: destHeight * destBytesPerRow)
            defer {
                destData.deallocate()
            }
            var destBuffer = vImage_Buffer(data: destData, height: vImagePixelCount(destHeight), width: vImagePixelCount(destWidth), rowBytes: destBytesPerRow)
            
            // scale the image
            error = vImageScale_ARGB8888(&sourceBuffer, &destBuffer, nil, numericCast(kvImageHighQualityResampling))
            guard error == kvImageNoError else { return nil }
            
            // create a CGImage from vImage_Buffer
            guard let destCGImage = vImageCreateCGImageFromBuffer(&destBuffer, &format, nil, nil, numericCast(kvImageNoFlags), &error)?.takeRetainedValue() else { return nil}
            guard error == kvImageNoError else { return nil }
            
            // create a UIImage
            let resizedImage = UIImage(cgImage: destCGImage, scale: scale, orientation: self.imageOrientation)
            return resizedImage
        }

}
