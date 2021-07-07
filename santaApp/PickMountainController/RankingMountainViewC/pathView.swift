//
//  pathView.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/07.
//

import UIKit

class pathView: UIView {

    let pattern : [CGFloat] = [2, 4]
    var start : CGPoint = CGPoint(x: 0, y: 0)
    var end : CGPoint = CGPoint(x: 0, y: 0)
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 2
        path.lineCapStyle = .round
        path.setLineDash(pattern, count: pattern.count, phase: 0)

        path.move(to: start)
        path.addLine(to: end)
        path.close()
        UIColor.mainColor.set()
        path.stroke()
    }
}
