//
//  AccountTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/25.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    static let identifier = "AccountTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLabelTitle()
        setLabelEmail()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Title label
    let labelTitle = UILabel()
    func setLabelTitle() {
        labelTitle.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 18)
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView.snp.leading).offset(27)
        }
    }
    // MARK: Email Label
    let labelEmail = UILabel()
    func setLabelEmail() {
        labelEmail.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 14)
        labelEmail.textAlignment = .right
        labelEmail.textColor = .bluegray
        contentView.addSubview(labelEmail)
        labelEmail.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
