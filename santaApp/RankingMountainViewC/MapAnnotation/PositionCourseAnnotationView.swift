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
        frame = CGRect(x: 0, y: 0, width: 68, height: 27)
        layer.cornerRadius = 14
        layer.borderWidth = 1
        layer.borderColor = UIColor.mainColor.cgColor
        backgroundColor = .white
        setLabelCourseName()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let labelCourseName = UILabel()
    func setLabelCourseName() {
        labelCourseName.textColor = .mainColor
        addSubview(labelCourseName)
        labelCourseName.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            backgroundColor = .mainColor
            labelCourseName.textColor = .white
        }
        else {
            backgroundColor = .white
            labelCourseName.textColor = .mainColor
        }
    }
}
