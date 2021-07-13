//
//  DetailPostTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/09.
//

import UIKit

class DetailPostTableViewCell: UITableViewCell {

    static let identifier = "DetailPostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SetViewUser()
        setImageViewMountain()
        setViewMountain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: 유저 정보
    let viewUser = UIView()
    let imageViewUser = UIImageView()
    let labelUserLv = UILabel()
    let labelUserName = UILabel()
    let buttonMore = UIButton()
    func SetViewUser() {
        contentView.addSubview(viewUser)
        viewUser.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(contentView)
            make.height.equalTo(63)
        }
        imageViewUser.layer.cornerRadius = 20.5
        imageViewUser.backgroundColor = .mainColor
        viewUser.addSubview(imageViewUser)
        imageViewUser.snp.makeConstraints { make in
            make.centerY.equalTo(viewUser)
            make.leading.equalTo(viewUser.snp.leading).offset(17)
            make.width.height.equalTo(41)
        }
        labelUserLv.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
        labelUserLv.textColor = .titleColorGray
        viewUser.addSubview(labelUserLv)
        labelUserLv.snp.makeConstraints { make in
            make.top.equalTo(viewUser.snp.top).offset(16)
            make.leading.equalTo(imageViewUser.snp.trailing).offset(12)
        }
        labelUserName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 18)
        viewUser.addSubview(labelUserName)
        labelUserName.snp.makeConstraints { make in
            make.top.equalTo(labelUserLv.snp.bottom)
            make.leading.equalTo(labelUserLv.snp.leading)
        }
        buttonMore.setImage(UIImage(named: "more@3x"), for: .normal)
        buttonMore.addTarget(self, action: #selector(actionButtonMore), for: .touchUpInside)
        viewUser.addSubview(buttonMore)
        buttonMore.snp.makeConstraints { make in
            make.centerY.equalTo(viewUser)
            make.trailing.equalTo(viewUser.snp.trailing).offset(-24)
            make.width.equalTo(4)
            make.height.equalTo(16)
        }
    }
    @objc func actionButtonMore() {
        print("click")
    }
    // MARK: 산 사진
    let imageViewwMountain = UIImageView()
    func setImageViewMountain() {
        imageViewwMountain.backgroundColor = .bluegray
        contentView.addSubview(imageViewwMountain)
        imageViewwMountain.snp.makeConstraints { make in
            make.top.equalTo(viewUser.snp.bottom)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(344)
        }
    }
    //MARK: 산 정보
    let viewMountain = UIView()
    let imageViewPosition = UIImageView()
    func setViewMountain() {
        contentView.addSubview(viewMountain)
        viewMountain.snp.makeConstraints { make in
            make.top.equalTo(imageViewwMountain.snp.bottom)
            make.leading.trailing.bottom.equalTo(contentView)
        }
        imageViewPosition.image = UIImage(named: "position@3x")
        viewMountain.addSubview(imageViewPosition)
        imageViewPosition.snp.makeConstraints { make in
            make.centerY.equalTo(viewMountain.snp.centerY)
            make.leading.equalTo(viewMountain.snp.leading).offset(16)
            make.width.equalTo(22.4)
            make.height.equalTo(26.7)
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
