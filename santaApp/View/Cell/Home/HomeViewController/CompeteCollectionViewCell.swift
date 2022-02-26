//
//  CompeteCollectionViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/12/27.
//

import UIKit

class CompeteCollectionViewCell: UICollectionViewCell {
    static let resueidentifier = "CompeteCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 뷰 구성 변수
    // 산 사진
    let imageViewMountain : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.backgroundColor = .paleblue
        imageView.clipsToBounds = true
        return imageView
    }()
    // 산 사진 경쟁중인가, 인기인가?
    let imageViewisPopular : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icHomeCompete")
        imageView.contentMode = .left
        return imageView
    }()
    // 난이도
    let imageViewDifficult : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "illustHome3")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // 산 이름
    let labelMountainName : UILabel = {
        let label = UILabel()
        label.text = "인왕산"
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 22)
        label.textColor = .black
        return label
    }()
    // 산 고도
    let labelMountainHeight : UILabel = {
        let label = UILabel()
        label.text = "(339.8m)"
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 12)
        label.addCharacterSpacing(kernValue: -0.36)
        label.textColor = .bluegray
        return label
    }()
    // 유저 이미지 배경 사진
    let imageViewUserProfileBackView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "946")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // 유저 마스크
    let imageViewMask : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // 유저 프로필
    let imageViewProfile : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "personhome")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // master 이미지
    let imageViewMaster : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "master")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    //MARK: contentView SET
    func setContentView() {
        self.addSubview(imageViewMountain)
        imageViewMountain.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(7)
            make.width.equalTo(90)
            make.height.equalTo(76)
        }
        
        self.addSubview(imageViewisPopular)
        imageViewisPopular.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(7)
            make.width.equalTo(75)
            make.height.equalTo(17.1)
        }
        
        self.addSubview(imageViewDifficult)
        imageViewDifficult.snp.makeConstraints { make in
            make.leading.equalTo(imageViewMountain.snp.trailing).offset(10.4)
            make.top.equalTo(self).offset(10.8)
            make.width.equalTo(77.7)
            make.height.equalTo(13.7)
        }
        
        self.addSubview(labelMountainName)
        labelMountainName.snp.makeConstraints { make in
            make.leading.equalTo(imageViewDifficult)
            make.top.equalTo(imageViewDifficult.snp.bottom).offset(4.2)
        }
        
        self.addSubview(labelMountainHeight)
        labelMountainHeight.snp.makeConstraints { make in
            make.leading.equalTo(labelMountainName.snp.trailing).offset(3.6)
            make.bottom.equalTo(labelMountainName).offset(-4)
        }
        
        self.addSubview(imageViewUserProfileBackView)
        imageViewUserProfileBackView.snp.makeConstraints { make in
            make.width.equalTo(53.5)
            make.height.equalTo(67.5)
            make.top.equalTo(self).offset(-5)
            make.trailing.equalTo(self).offset(-23.7)
        }
        
        imageViewUserProfileBackView.addSubview(imageViewProfile)
        imageViewProfile.snp.makeConstraints { make in
            make.width.equalTo(38.5)
            make.height.equalTo(51.5)
            make.center.equalTo(imageViewUserProfileBackView)
        }
        let mask = CALayer()
        mask.contents = UIImage(named: "mask@3x")?.cgImage as Any
        mask.frame = CGRect(x: 0, y: 0, width: 36, height: 46)
        imageViewProfile.layer.mask = mask
        imageViewProfile.layer.masksToBounds = true
        
        imageViewUserProfileBackView.addSubview(imageViewMaster)
        imageViewMaster.snp.makeConstraints { make in
            make.centerY.equalTo(imageViewUserProfileBackView).offset(8)
            make.centerX.equalTo(imageViewUserProfileBackView)
            make.width.equalTo(46.1)
            make.height.equalTo(14.2)
        }
    }
}
