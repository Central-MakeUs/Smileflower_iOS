//
//  MyRankTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/06.
//

import UIKit

class MyRankTableViewCell: UITableViewCell {

    static let identifier = "MyRankTableViewCell"

    let labelRank = UILabel()
    let imageViewProfile = UIImageView()
    let labelUserLV = UILabel()
    let labelUserName = UILabel()
    let labelUserTimes = UILabel()
    let labelUserlatest = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        labelSetLabel()
        imageViewSetProfile()
        labelSetUserLV()
        labelSetUserName()
        labelSetUserTimes()
        labelSetLatest()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func labelSetLabel() {
        labelRank.textAlignment = .center
        labelRank.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 20)
        labelRank.textColor = .white
        contentView.addSubview(labelRank)
        labelRank.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.width.equalTo(36)
            make.height.equalTo(17)
        }
    }
    func imageViewSetProfile() {
        contentView.addSubview(imageViewProfile)
        imageViewProfile.snp.makeConstraints { make in
            make.centerY.equalTo(labelRank.snp.centerY)
            make.leading.equalTo(labelRank.snp.trailing).offset(6)
            make.width.height.equalTo(37)
        }
    }
    func labelSetUserLV() {
        labelUserLV.textColor = .white
        labelUserLV.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
        contentView.addSubview(labelUserLV)
        labelUserLV.snp.makeConstraints { make in
            make.leading.equalTo(imageViewProfile.snp.trailing).offset(18)
            make.top.equalTo(contentView.snp.top).offset(15)
        }
    }
    func labelSetUserName() {
        labelUserName.textColor = .white
        labelUserName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 15)
        contentView.addSubview(labelUserName)
        labelUserName.snp.makeConstraints { make in
            make.leading.equalTo(labelUserLV.snp.leading)
            make.top.equalTo(labelUserLV.snp.bottom)
        }
    }
    func labelSetLatest() {
        labelUserlatest.textColor = .white
        labelUserlatest.textAlignment = .center
        labelUserlatest.layer.borderWidth = 0.5
        labelUserlatest.layer.borderColor = UIColor.white.cgColor
        labelUserlatest.layer.cornerRadius = 7
        labelUserlatest.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 11)
        contentView.addSubview(labelUserlatest)
        labelUserlatest.snp.makeConstraints { make in
            make.bottom.equalTo(labelUserTimes.snp.top).offset(-2.2)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12.7)
            make.width.equalTo(37)
            make.height.equalTo(13)
        }
    }
    func labelSetUserTimes() {
        labelUserTimes.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)
        labelUserTimes.textAlignment = .center
        labelUserTimes.textColor = .white
        contentView.addSubview(labelUserTimes)
        labelUserTimes.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-9.4)
            make.centerY.equalTo(labelUserName.snp.centerY)
            make.width.equalTo(43.5)
            make.height.equalTo(16)
        }
    }
}
