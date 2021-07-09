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
        labelSetMountain()
        labelSetMountainHeight()
        buttonSetLike()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 산 이미지
    let imageViewMountain = UIImageView()
    func imageViewSetMountain() {
        imageViewMountain.backgroundColor = .mainColor
        imageViewMountain.layer.cornerRadius = 16
        contentView.addSubview(imageViewMountain)
        imageViewMountain.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(7)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(112)
            make.height.equalTo(95)
        }
    }
    // MARK: 산 이름
    let labelMountain = UILabel()
    func labelSetMountain() {
        labelMountain.text = "인왕산"
        labelMountain.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 24)
        contentView.addSubview(labelMountain)
        labelMountain.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.leading.equalTo(imageViewMountain.snp.trailing).offset(13)
            make.width.equalTo(65)
        }
    }
    // MARK: 산 높이
    let labelMountainHeight = UILabel()
    func labelSetMountainHeight() {
        labelMountainHeight.text = "(339.8m)"
        labelMountainHeight.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 14)
        labelMountainHeight.textColor = .titleColorGray
        contentView.addSubview(labelMountainHeight)
        labelMountainHeight.snp.makeConstraints { make in
            make.leading.equalTo(labelMountain.snp.trailing).offset(6)
            make.bottom.equalTo(labelMountain.snp.bottom)
        }
    }
    // MARK: 하트 버튼
    let buttonLike = UIButton()
    func buttonSetLike() {
        buttonLike.setImage(UIImage(named: "heartSelected@3x"), for: .normal)
        contentView.addSubview(buttonLike)
        buttonLike.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(17.2)
            make.trailing.equalTo(contentView.snp.trailing).offset(-17.2)
            make.width.equalTo(19.8)
            make.height.equalTo(18.2)
        }
    }
}
