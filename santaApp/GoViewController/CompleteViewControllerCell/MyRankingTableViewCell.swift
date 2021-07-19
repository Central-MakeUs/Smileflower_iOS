//
//  RankingTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/18.
//

import UIKit

class MyRankingTableViewCell: UITableViewCell {
    static let resueidentifier = "MyRankingTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLabelRank()
        setimageViewUserProfile()
        setLabelUserLv()
        setLabelUserName()
        setImageViewFlag()
        setLabelConquered()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let labelRank = UILabel()
    func setLabelRank() {
        labelRank.textAlignment = .center
        labelRank.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 19)
        contentView.addSubview(labelRank)
        labelRank.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView).offset(21)
            make.width.equalTo(34)
        }
    }
    //MARK: 유저 이미지 3개
    let imageViewUserProfile = UIImageView()
    let imageViewUser = UIImageView()
    let imagemask = UIImageView()
    
    func setimageViewUserProfile() {
        imageViewUserProfile.contentMode = .scaleAspectFit
        contentView.addSubview(imageViewUserProfile)
        imageViewUser.contentMode = .scaleAspectFill
        imageViewUserProfile.addSubview(imageViewUser)
        imageViewUser.snp.makeConstraints { make in
            make.centerX.equalTo(imageViewUserProfile.snp.centerX).offset(-1)
            make.centerY.equalTo(imageViewUserProfile.snp.centerY).offset(-3.1)
            make.width.equalTo(43.9)
            make.height.equalTo(61.8)
        }
        imagemask.image = UIImage(named: "mask@3x")
        imageViewUser.mask = imagemask
    }
    //MARK: 유저 레벨
    let labelUserLv = UILabel()
    func setLabelUserLv() {
        labelUserLv.textColor = .bluegray
        labelUserLv.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
        contentView.addSubview(labelUserLv)
        labelUserLv.snp.makeConstraints { make in
            make.leading.equalTo(imageViewUserProfile.snp.trailing).offset(2)
            make.centerY.equalTo(imageViewUserProfile.snp.centerY)
        }
    }
    //MARK: 유저 이름
    let labelUserName = UILabel()
    func setLabelUserName() {
        labelUserName.textColor = .darkbluegray
        labelUserName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 18)
        contentView.addSubview(labelUserName)
        labelUserName.snp.makeConstraints { make in
            make.leading.equalTo(labelUserLv.snp.leading)
            make.top.equalTo(labelUserLv.snp.bottom)
        }
    }
    //MARK: 깃발 아이콘
    let imageViewFlag = UIImageView()
    func setImageViewFlag() {
        imageViewFlag.image = UIImage(named: "FlagIconMainColor@3x")
        imageViewFlag.contentMode = .scaleAspectFit
        contentView.addSubview(imageViewFlag)
        imageViewFlag.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-32.7)
            make.bottom.equalTo(labelUserName.snp.bottom).offset(-3)
            make.width.equalTo(16.8)
            make.height.equalTo(17.5)
        }
    }
    //MARK: 산 탄 횟수
    let labelConquered = UILabel()
    func setLabelConquered() {
        labelConquered.textColor = .mainColor
        labelConquered.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 20)
        labelConquered.textAlignment = .right
        contentView.addSubview(labelConquered)
        labelConquered.snp.makeConstraints { make in
            make.trailing.equalTo(imageViewFlag.snp.leading).offset(-6.2)
            make.bottom.equalTo(labelUserName.snp.bottom)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
