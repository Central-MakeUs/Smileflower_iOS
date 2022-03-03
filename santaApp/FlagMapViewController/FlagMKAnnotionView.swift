//
//  FlagMKAnnotionView.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/23.
//

import UIKit
import MapKit

class FlagMKAnnotionView: MKAnnotationView {
    static let identifier = "FlagMKAnnotionView"
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 55.7, height: 58)
        setImageViewFlag()
    }
    let imageViewFlag = UIImageView()
    func setImageViewFlag() {
        addSubview(imageViewFlag)
        imageViewFlag.contentMode = .scaleAspectFit
        imageViewFlag.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
