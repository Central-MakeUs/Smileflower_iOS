//
//  UIView.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/02.
//

import UIKit

extension UIView{
    func setGradient(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
        }
}
