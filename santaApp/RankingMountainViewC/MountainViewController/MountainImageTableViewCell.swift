//
//  MountainImageTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/08.
//

import UIKit

class MountainImageTableViewCell: UITableViewCell {

    static let identifier = "MountainImageTableViewCell"
    var mountainIdx : Int?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setImage()
        setButton()
        setMountainName()
        setImageViewFamousMountain()
        setImageViewMountainDifficulty()
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
        imageViewMountain.clipsToBounds = true
        imageViewMountain.contentMode = .scaleAspectFill
        imageViewMountain.layer.cornerRadius = 18
        contentView.addSubview(imageViewMountain)
        imageViewMountain.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.bottom.equalTo(contentView)
            make.width.equalTo(329)
        }
    }
    //MARK: 찜하기 버튼
    let buttonLike = UIButton()
    func setButton() {
        buttonLike.setImage(UIImage(named: "heartUnSelected@3x"), for: .normal)
        buttonLike.setImage(UIImage(named: "heartSelected@3x"), for: .selected)
        buttonLike.backgroundColor = UIColor(hex: 0xf0f2f5)
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
        if let idx = mountainIdx {
            MountainLikeDataManager().apppicksmountainIdx(idx)
        }
    }
    //MARK: 산 이름
    let labelMountainName = UILabel()
    func setMountainName() {
        labelMountainName.textColor = .white
        labelMountainName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 32)
        
        contentView.addSubview(labelMountainName)
        labelMountainName.snp.makeConstraints { make in
            make.leading.equalTo(imageViewMountain.snp.leading).offset(16)
            make.bottom.equalTo(imageViewMountain.snp.bottom).offset(-15)
        }
    }
    //MARK: 난이도 표시하기
    let imageViewMountainDifficulty = UIImageView()
    func setImageViewMountainDifficulty() {
        imageViewMountainDifficulty.contentMode = .scaleAspectFit
        contentView.addSubview(imageViewMountainDifficulty)
        imageViewMountainDifficulty.snp.makeConstraints { make in
            make.bottom.equalTo(labelMountainName.snp.bottom).offset(-8)
            make.leading.equalTo(labelMountainName.snp.trailing).offset(14)
            make.width.equalTo(106.1)
            make.height.equalTo(18.7)
        }
    }
    //MARK: 인기하고 100대 명산 라벨
    let imageViewFamousMountain = UIImageView()
    let imageViewHotMountain = UIImageView()
    func setImageViewFamousMountain() {
        imageViewFamousMountain.image = UIImage(named: "icInfo100")
        imageViewFamousMountain.contentMode = .scaleAspectFit
        contentView.addSubview(imageViewFamousMountain)
        imageViewFamousMountain.snp.makeConstraints { make in
            make.leading.equalTo(labelMountainName.snp.leading)
            make.bottom.equalTo(labelMountainName.snp.top).offset(-1)
            make.width.equalTo(51)
            make.height.equalTo(15)
        }
        imageViewFamousMountain.contentMode = .scaleAspectFit
        contentView.addSubview(imageViewHotMountain)
        imageViewHotMountain.snp.makeConstraints { make in
            make.leading.equalTo(imageViewFamousMountain.snp.trailing).offset(3)
            make.centerY.equalTo(imageViewFamousMountain.snp.centerY)
            make.width.equalTo(27)
            make.height.equalTo(15)
        }
    }
}
