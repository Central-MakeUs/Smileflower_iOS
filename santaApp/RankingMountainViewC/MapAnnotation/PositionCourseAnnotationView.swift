//
//  PositionMountainAnnotationView.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/20.
//

import UIKit
import MapKit

class PositionCourseAnnotationView: MKAnnotationView {
    static let identifier = "PositionCourseAnnotationView"
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 59, height: 70)
        SetimageView()
        setLabelMountainName()
        self.backgroundColor = .black
    }
    let imageViewRedPosition = UIImageView()
    func SetimageView() {
        imageViewRedPosition.image = UIImage(named: "redPosition@3x")
        self.addSubview(imageViewRedPosition)
        imageViewRedPosition.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.width.equalTo(37.3)
            make.height.equalTo(44.3)
        }
    }
    let labelMountainName = UILabel()
    func setLabelMountainName() {
        labelMountainName.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 16)
        labelMountainName.textAlignment = .center
        labelMountainName.textColor = .titleColorGray
        self.addSubview(labelMountainName)
        labelMountainName.snp.makeConstraints { make in
            make.centerX.equalTo(imageViewRedPosition)
            make.top.equalTo(imageViewRedPosition.snp.bottom).offset(10)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
