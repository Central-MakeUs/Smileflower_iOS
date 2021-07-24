//
//  UITextField.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/24.
//

import UIKit

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.mainColor.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
