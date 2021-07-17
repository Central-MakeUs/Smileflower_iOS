//
//  VersionTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/16.
//

import UIKit

class VersionTableViewCell: UITableViewCell {

    static let identifier = "VersionTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let labelTitle = UILabel()
    let labelVersion = UILabel()
    func setLabel() {
        labelTitle.text = "버전 정보"
        labelTitle.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 18)
        labelTitle.textColor = .darkbluegray
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(27)
        }
        labelVersion.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 18)
        labelVersion.textColor = UIColor(hex: 0x44b4aa)
        contentView.addSubview(labelVersion)
        labelVersion.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
