//
//  MountainPositionTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/08.
//

import UIKit

class MountainPositionTableViewCell: UITableViewCell {

    static let identifier = "MountainPositionTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageViewSetPosition()
        labelSetPosition()
        labelSetMountainAddress()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: 위치 이미지
    let imageViewPosition = UIImageView()
    func imageViewSetPosition() {
        imageViewPosition.image = UIImage(named: "icInfoLocation@3x")
        contentView.addSubview(imageViewPosition)
        imageViewPosition.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(25)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
    }
    //MARK: 위치 라벨
    let labelPosition = UILabel()
    func labelSetPosition() {
        labelPosition.text = "위치"
        labelPosition.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelPosition.textColor = .titleColorGray
        contentView.addSubview(labelPosition)
        labelPosition.snp.makeConstraints { make in
            make.centerY.equalTo(imageViewPosition.snp.centerY)
            make.leading.equalTo(imageViewPosition.snp.trailing).offset(3)
        }
    }
    //MARK: 산 주소
    let labelMountainAddress = UILabel()
    func labelSetMountainAddress() {
        labelMountainAddress.text = "서울 특별시 종로구 서대문구"
        labelMountainAddress.numberOfLines = 2
        labelMountainAddress.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        contentView.addSubview(labelMountainAddress)
        labelMountainAddress.snp.makeConstraints { make in
            make.top.equalTo(labelPosition.snp.top)
            make.leading.equalTo(labelPosition.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
