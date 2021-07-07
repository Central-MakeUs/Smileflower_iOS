//
//  MountainImageTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/08.
//

import UIKit

class MountainImageTableViewCell: UITableViewCell {

    static let identifier = "MountainImageTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setImage()
//        setFilter()
        setButton()
        setMountainName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK: 사진
    let imageViewMountain = UIImageView()
    func setImage() {
        imageViewMountain.backgroundColor = .mainColor
        imageViewMountain.layer.cornerRadius = 18
        contentView.addSubview(imageViewMountain)
        imageViewMountain.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.bottom.equalTo(contentView)
            make.width.equalTo(329)
        }
    }
    //MARK: 그라데이션 필터
    let viewFilter = UIView()
    func setFilter() {
        viewFilter.backgroundColor = .white
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = viewFilter.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        viewFilter.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(viewFilter)
        viewFilter.snp.makeConstraints { make in
            make.edges.equalTo(imageViewMountain)
        }
    }
    //MARK: 찜하기 버튼
    let buttonLike = UIButton()
    func setButton() {
        buttonLike.setImage(UIImage(named: "heartUnSelected@3x"), for: .normal)
        buttonLike.setImage(UIImage(named: "heartSelected@3x"), for: .selected)
        buttonLike.backgroundColor = .white
        buttonLike.layer.cornerRadius = 21
        buttonLike.addTarget(self, action: #selector(actionButtonLike), for: .touchUpInside)
        contentView.addSubview(buttonLike)
        buttonLike.snp.makeConstraints { make in
            make.trailing.equalTo(imageViewMountain.snp.trailing).offset(-13)
            make.top.equalTo(imageViewMountain.snp.top).offset(15)
            make.width.equalTo(42)
            make.height.equalTo(42)
        }
    }
    @objc func actionButtonLike() {
        if buttonLike.isSelected {
            buttonLike.isSelected = false
        }
        else {
            buttonLike.isSelected = true
        }
    }
    //MARK: 산 이름
    let labelMountainName = UILabel()
    func setMountainName() {
        labelMountainName.text = "인왕산"
        labelMountainName.textColor = .white
        labelMountainName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 32)
        
        contentView.addSubview(labelMountainName)
        labelMountainName.snp.makeConstraints { make in
            make.leading.equalTo(imageViewMountain.snp.leading).offset(16)
            make.bottom.equalTo(imageViewMountain.snp.bottom).offset(-17)
        }
    }
}
