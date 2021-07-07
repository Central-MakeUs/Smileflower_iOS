//
//  pathView.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/07.
//

import UIKit

class pathView: UIView {

    let pattern : [CGFloat] = [2, 4]
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 2
        path.lineCapStyle = .round
        path.setLineDash(pattern, count: pattern.count, phase: 0)

        path.move(to: CGPoint(x: 38.6, y: 275))
        path.addLine(to: CGPoint(x: 38.6, y: 575.5))
        path.close()
        UIColor.mainColor.set()
        path.stroke()
    }
}
