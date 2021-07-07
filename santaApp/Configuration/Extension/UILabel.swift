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
