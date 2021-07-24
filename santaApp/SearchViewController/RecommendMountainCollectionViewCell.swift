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
        setimaegViewisHot()
        setImageViewDifficulty()
        setlabelMountainName()
        setLableMountainHeight()
        setButtonMountainLike()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: 산 사진
    let imageViewMountain = UIImageView()
    func setimageViewMountain() {
        imageViewMountain.layer.cornerRadius = 16
        imageViewMountain.contentMode = .scaleAspectFill
        imageViewMountain.clipsToBounds = true
        contentView.addSubview(imageViewMountain)
        imageViewMountain.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(7)
            make.width.equalTo(90)
            make.height.equalTo(76)
        }
    }
    let imageViewIsHot = UIImageView()
    func setimaegViewisHot() {
        contentView.addSubview(imageViewIsHot)
        imageViewIsHot.snp.makeConstraints { make in
            make.leading.top.equalTo(imageViewMountain)
            make.width.equalTo(40)
            make.height.equalTo(17.2)
        }
    }
    //MARK: 산 난이도
    let imageViewDifficulty = UIImageView()
    func setImageViewDifficulty() {
        imageViewDifficulty.image = UIImage(named: "illustHome4@3x")
        contentView.addSubview(imageViewDifficulty)
        imageViewDifficulty.snp.makeConstraints { make in
            make.top.equalTo(imageViewMountain)
            make.leading.equalTo(imageViewMountain.snp.trailing).offset(9.4)
            make.width.equalTo(77.7)
            make.height.equalTo(13.7)
        }
    }
    //MARK: 산 이름
    let labelMountainName = UILabel()
    func setlabelMountainName() {
        labelMountainName.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 22)
        contentView.addSubview(labelMountainName)
        labelMountainName.snp.makeConstraints { make in
            make.top.equalTo(imageViewDifficulty.snp.bottom).offset(3.7)
            make.leading.equalTo(imageViewDifficulty.snp.leading)
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
    //MARK: 찜한 산 버튼
    let buttonMountainLike = UIButton()
    var mountainIdx : Int?
    func setButtonMountainLike() {
        buttonMountainLike.setImage(UIImage(named: "heartUnSelected@3x"), for: .normal)
        buttonMountainLike.setImage(UIImage(named: "heartSelected@3x"), for: .selected)
        buttonMountainLike.addTarget(self, action: #selector(actionMountainLike), for: .touchUpInside)
        contentView.addSubview(buttonMountainLike)
        buttonMountainLike.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
    }
    @objc func actionMountainLike() {
        if buttonMountainLike.isSelected {
            buttonMountainLike.isSelected = false
        }
        else {
            buttonMountainLike.isSelected = true
        }
        if let idx = mountainIdx {
            MountainLikeDataManager().apppicksmountainIdx(idx)
        }
    }
}
