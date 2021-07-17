//
//  LikeMountainCollectionViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/09.
//

import UIKit

class LikeMountainCollectionViewCell: UICollectionViewCell {
    static let resueidentifier = "LikeMountainCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageViewSetMountain()
        setimageViewDifficulty()
        labelSetMountain()
        labelSetMountainHeight()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 산 이미지
    let imageViewMountain = UIImageView()
    func imageViewSetMountain() {
        imageViewMountain.layer.cornerRadius = 16
        imageViewMountain.clipsToBounds  = true
        contentView.addSubview(imageViewMountain)
        imageViewMountain.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(7)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(112)
            make.height.equalTo(95)
        }
    }
    //MARK: 난이도 이미지
    let imageViewDifficulty = UIImageView()
    func setimageViewDifficulty() {
        contentView.addSubview(imageViewDifficulty)
        imageViewDifficulty.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.leading.equalTo(imageViewMountain.snp.trailing).offset(13)
            make.width.equalTo(76.2)
            make.height.equalTo(13.8)
        }
    }
    // MARK: 산 이름
    let labelMountain = UILabel()
    func labelSetMountain() {
        labelMountain.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 24)
        contentView.addSubview(labelMountain)
        labelMountain.snp.makeConstraints { make in
            make.top.equalTo(imageViewDifficulty.snp.bottom).offset(1.8)
            make.leading.equalTo(imageViewDifficulty.snp.leading)
        }
    }
    // MARK: 산 높이
    let labelMountainHeight = UILabel()
    func labelSetMountainHeight() {
        labelMountainHeight.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 14)
        labelMountainHeight.textColor = .titleColorGray
        contentView.addSubview(labelMountainHeight)
        labelMountainHeight.snp.makeConstraints { make in
            make.leading.equalTo(labelMountain.snp.trailing).offset(6)
            make.bottom.equalTo(labelMountain.snp.bottom)
        }
    }
}
