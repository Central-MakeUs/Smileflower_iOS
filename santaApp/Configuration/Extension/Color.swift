//
//  Color.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/30.
//

import UIKit

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var mainColor: UIColor { UIColor(hex: 0x44B4AA) }
    class var titleColorGray: UIColor { UIColor(hex: 0x7C909B) }
    class var darkbluegray : UIColor { UIColor(hex: 0x1C3240)}
    class var bluegray : UIColor { UIColor(hex: 0x7c909b) }
    class var lightbluegray : UIColor { UIColor(hex: 0xc1cad0)}
    class var iceblue : UIColor { UIColor(hex: 0xf1f7f9)}
    class var paleblue : UIColor { UIColor(hex: 0xdfe5ed)}
    class var paleblue97 : UIColor { UIColor(hex: 0xdfe5ed, alpha: 0.97)}
    class var coral : UIColor { UIColor(hex: 0xf05b55)}
}
