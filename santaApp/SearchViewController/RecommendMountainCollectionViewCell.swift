//
//  RecommendMountainCollectionViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/11.
//

import UIKit

class RecommendMountainCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendMountainCollectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setimageViewMountain()
        setlabelMountainName()
        setLableMountainHeight()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: 산 사진
    let imageViewMountain = UIImageView()
    func setimageViewMountain() {
        imageViewMountain.backgroundColor = .mainColor
        imageViewMountain.layer.cornerRadius = 16
        contentView.addSubview(imageViewMountain)
        imageViewMountain.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(7)
            make.width.equalTo(90)
            make.height.equalTo(76)
        }
    }
    //MARK: 산 이름
    let labelMountainName = UILabel()
    func setlabelMountainName() {
        labelMountainName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 22)
        contentView.addSubview(labelMountainName)
        labelMountainName.snp.makeConstraints { make in
            make.top.equalTo(imageViewMountain)
            make.leading.equalTo(imageViewMountain.snp.trailing).offset(9.4)
        }
    }
    //MARK: 산 높이
    let labelMountainHeight = UILabel()
    func setLableMountainHeight() {
        labelMountainHeight.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 12)
        labelMountainHeight.addCharacterSpacing(kernValue: -0.36)
        labelMountainHeight.textColor = .titleColorGray
        contentView.addSubview(labelMountainHeight)
        labelMountainHeight.snp.makeConstraints { make in
            make.bottom.equalTo(labelMountainName).offset(-2)
            make.leading.equalTo(labelMountainName.snp.trailing).offset(4.6)
        }
    }
}
