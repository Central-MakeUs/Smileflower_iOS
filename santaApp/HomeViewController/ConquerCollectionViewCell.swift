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
    let imageViewMountain = UIImageView()
    let labelMountainName = UILabel()
    let imageViewProfile = UIImageView()
    let imageViewGrade = UIImageView()
    let labelName = UILabel()
    let labelConquer = UILabel()
    let labelConquerNumberOfTimes = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageViewSetMountain()
        labelSetMountainName()
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
        contentView.addSubview(imageViewMountain)
        
        imageViewMountain.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    // MARK: 북한산
    func labelSetMountainName() {
        labelMountainName.text = "관악산"
        labelMountainName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 22)
        
        contentView.addSubview(labelMountainName)
        
        labelMountainName.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.top.equalTo(imageViewMountain.snp.bottom).offset(12)
        }
    }
    // MARK: 프로필
    func viewSetProfile() {
        imageViewProfile.image = UIImage(named: "profileView@3x")
        imageViewProfile.contentMode = .scaleAspectFill
        contentView.addSubview(imageViewProfile)
        
        imageViewProfile.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(12.1)
            make.top.equalTo(labelMountainName.snp.bottom).offset(8.9)
            make.width.equalTo(41)
            make.height.equalTo(53.8)
        }
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
            make.leading.equalTo(imageViewGrade.snp.trailing).offset(35.7)
        }
    }
//    // MARk : 횟수
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
