//
//  ConquerMountainCollectionViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/08.
//

import UIKit

class ConquerMountainCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: ConquerMountainCollectionViewCell.self)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImageViewMountainConquer()
        setImageViewFlag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: 산 사진
    let imageViewMountainConquer = UIImageView()
    func setImageViewMountainConquer() {
        imageViewMountainConquer.clipsToBounds = true
        imageViewMountainConquer.contentMode = .scaleAspectFill
        contentView.addSubview(imageViewMountainConquer)
        imageViewMountainConquer.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    // MARK: 산 정복 사진인가?
    let imageViewFlag = UIImageView()
    func setImageViewFlag() {
        imageViewFlag.contentMode = .scaleAspectFit
        contentView.addSubview(imageViewFlag)
        imageViewFlag.snp.makeConstraints { make in
            make.top.equalTo(imageViewMountainConquer.snp.top).offset(7.7)
            make.trailing.equalTo(imageViewMountainConquer.snp.trailing).offset(-7.7)
            make.width.equalTo(15.6)
            make.height.equalTo(16.9)
        }
    }
}
