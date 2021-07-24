//
//  ConquerCollectionViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/01.
//

import UIKit
import SnapKit

class ConquerCollectionViewCell: UICollectionViewCell {
    static let identifier = "conquerCollectionViewCell"
    var imageViewMountain = UIImageView()
    var labelMountainName = UILabel()
    var imageViewProfile = UIImageView()
    var imageViewGrade = UIImageView()
    var labelName = UILabel()
    var labelConquer = UILabel()
    var labelConquerNumberOfTimes = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageViewSetMountain()
        labelSetMountainName()
        setImageViewDifficulty()
        viewSetProfile()
        imageViewSetGrade()
        labelSetName()
        labelSetConquer()
        labelSetConquerNumberOfTimes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 이미지 만들기
    func imageViewSetMountain() {
        imageViewMountain.backgroundColor = .white
        imageViewMountain.layer.cornerRadius = 20
        imageViewMountain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageViewMountain.contentMode = .scaleAspectFill
        imageViewMountain.clipsToBounds = true
        contentView.addSubview(imageViewMountain)
        
        imageViewMountain.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
            make.height.equalTo(100)
        }
    }
    // MARK: 북한산
    func labelSetMountainName() {
        labelMountainName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 19)
        labelMountainName.addCharacterSpacing(kernValue: -0.38)
        contentView.addSubview(labelMountainName)
        
        labelMountainName.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.top.equalTo(imageViewMountain.snp.bottom).offset(12)
        }
    }
    // MARK: 난이도
    let imageViewDifficulty = UIImageView()
    func setImageViewDifficulty() {
        imageViewDifficulty.contentMode = .scaleAspectFit
        contentView.addSubview(imageViewDifficulty)
        imageViewDifficulty.snp.makeConstraints { make in
            make.centerY.equalTo(labelMountainName.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-8.9)
            make.width.equalTo(68.4)
            make.height.equalTo(12.1)
        }
    }
    // MARK: 프로필
    var imageProfile = UIImageView()
    let imagemask = UIImageView()
    func viewSetProfile() {
        imageViewProfile.image = UIImage(named: "946@3x")
        imageViewProfile.contentMode = .scaleAspectFill
        contentView.addSubview(imageViewProfile)
        
        imageViewProfile.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(0)
            make.top.equalTo(labelMountainName.snp.bottom).offset(0)
            make.width.equalTo(59.2)
            make.height.equalTo(72)
        }
        imageProfile.image = UIImage(named: "그라데이션")
        imageProfile.contentMode = .scaleAspectFill
        imageViewProfile.addSubview(imageProfile)
        imageProfile.snp.makeConstraints { make in
            make.centerX.equalTo(imageViewProfile.snp.centerX).offset(-1)
            make.centerY.equalTo(imageViewProfile.snp.centerY).offset(-2)
            make.width.equalTo(35.5)
            make.height.equalTo(47.1)
        }
        imagemask.image = UIImage(named: "mask@3x")
        imageProfile.mask = imagemask
    }
    // MARK: 등급
    func imageViewSetGrade() {
        imageViewGrade.image = UIImage(named: "master@3x")
        imageViewGrade.contentMode = .scaleAspectFill
        contentView.addSubview(imageViewGrade)
        
        imageViewGrade.snp.makeConstraints { make in
            make.centerY.equalTo(imageViewProfile.snp.centerY)
            make.leading.equalTo(imageViewProfile.snp.trailing).offset(7.7)
            make.width.equalTo(43.4)
            make.height.equalTo(12.5)
        }
    }
    // MARK: 이름
    func labelSetName() {
        labelName.text = "에스핀"
        labelName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 13)
        
        contentView.addSubview(labelName)
        
        labelName.snp.makeConstraints { make in
            make.leading.equalTo(imageViewGrade.snp.leading)
            make.top.equalTo(imageViewGrade.snp.bottom).offset(3.1)
        }
    }
    // MARK: 정복
    func labelSetConquer() {
        labelConquer.text = "정복"
        labelConquer.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 9)
        labelConquer.textColor = UIColor(hex: 0x92969d)
        labelConquer.textAlignment = .right
        
        contentView.addSubview(labelConquer)
        
        labelConquer.snp.makeConstraints { make in
            make.centerY.equalTo(imageViewProfile.snp.centerY)
            make.leading.equalTo(contentView.snp.trailing).offset(-23)
        }
    }
//    // MARk: 횟수
    func labelSetConquerNumberOfTimes() {
        labelConquerNumberOfTimes.text = "7회"
        labelConquerNumberOfTimes.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 14)
        labelConquerNumberOfTimes.textColor = UIColor(hex: 0x92969d)
        labelConquerNumberOfTimes.textAlignment = .right

        contentView.addSubview(labelConquerNumberOfTimes)

        labelConquerNumberOfTimes.snp.makeConstraints { make in
            make.trailing.equalTo(labelConquer.snp.trailing)
            make.top.equalTo(labelConquer.snp.bottom).offset(3)
        }
    }
}
