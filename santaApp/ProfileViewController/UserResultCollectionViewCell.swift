//
//  UserResultCollectionViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/08.
//

import UIKit

class UserResultCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: UserResultCollectionViewCell.self)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImageViewResult()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: 성과 사진
    let imageViewResult = UIImageView()
    func setImageViewResult() {
        imageViewResult.contentMode = .scaleAspectFit
        imageViewResult.clipsToBounds = true
        contentView.addSubview(imageViewResult)
        imageViewResult.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.width.equalTo(81.3)
            make.height.equalTo(94.2)
        }
    }
}
