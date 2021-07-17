//
//  LogoutTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/16.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {

    static let identifier = "LogoutTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let labelTitle = UILabel()
    func setLabel() {
        labelTitle.text = "로그아웃"
        labelTitle.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 18)
        labelTitle.textColor = .bluegray
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(27)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
