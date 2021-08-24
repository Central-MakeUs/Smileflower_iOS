//
//  UILabel.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/01.
//

import UIKit

extension UILabel {
    // MARK: 자간 간격
    func addCharacterSpacing(kernValue: Double = -1.65) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
    //MARK: LineHeight
    func setTextWithLineHeight(text: String?, lineHeight: CGFloat) {
            if let text = text {
                let style = NSMutableParagraphStyle()
                style.maximumLineHeight = lineHeight
                style.minimumLineHeight = lineHeight
                
                let attributes: [NSAttributedString.Key: Any] = [
                    .paragraphStyle: style, .baselineOffset: (lineHeight - font.lineHeight)/4
                ]
                    
                let attrString = NSAttributedString(string: text,
                                                    attributes: attributes)
                self.attributedText = attrString
            }
        }
}

extension UILabel {
    func dynamicFont(fontSize size: CGFloat, weight: UIFont.Weight) {
        let currentFontName = self.font.fontName
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        switch height {
        case 480.0: //Iphone 3,4S => 3.5 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 0.7)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
            break
        case 568.0: //iphone 5, SE => 4 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 0.8)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
            break
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 0.92)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
            break
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 0.95)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
            break
        case 812.0: //iphone X, XS => 5.8 inch
            calculatedFont = UIFont(name: currentFontName, size: size)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
            break
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 1.15)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
            break
        default:
            print("not an iPhone")
            break
        }
    }
    private func resizeFont(calculatedFont: UIFont?, weight: UIFont.Weight) {
        self.font = calculatedFont
        self.font = UIFont.systemFont(ofSize: calculatedFont!.pointSize, weight: weight)
    }
}
