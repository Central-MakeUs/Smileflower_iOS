//
//  MountainHeightTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/08.
//

import UIKit

class MountainHeightTableViewCell: UITableViewCell {

    static let identifier = "MountainHeightTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageViewSetHeight()
        labelSetHeight()
        labelSetHeightConstant()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //MARK: 높이 이미지
    let imageViewHeight = UIImageView()
    func imageViewSetHeight() {
        imageViewHeight.image = UIImage(named: "mountainICON@3x")
        contentView.addSubview(imageViewHeight)
        imageViewHeight.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(25)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
    }
    //MARK: 높이 라벨
    let labelHeight = UILabel()
    func labelSetHeight() {
        labelHeight.text = "높이"
        labelHeight.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelHeight.textColor = .titleColorGray
        contentView.addSubview(labelHeight)
        labelHeight.snp.makeConstraints { make in
            make.centerY.equalTo(imageViewHeight.snp.centerY)
            make.leading.equalTo(imageViewHeight.snp.trailing).offset(3)
        }
    }
    //MARK: 높이
    let labelHeightConstant = UILabel()
    func labelSetHeightConstant() {
        labelHeightConstant.text = "339.8m"
        labelHeightConstant.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelHeightConstant.textColor = .darkbluegray
        contentView.addSubview(labelHeightConstant)
        labelHeightConstant.snp.makeConstraints { make in
            make.top.equalTo(labelHeight.snp.top)
            make.leading.equalTo(labelHeight.snp.trailing).offset(15)
        }
    }
}
