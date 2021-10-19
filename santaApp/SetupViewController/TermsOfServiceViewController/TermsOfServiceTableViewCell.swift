//
//  TermsOfServiceTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/25.
//

import UIKit

class TermsOfServiceTableViewCell: UITableViewCell {

    static let identifier = "TermsOfServiceTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLabelTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Title label
    let labelTitle = UILabel()
    func setLabelTitle() {
        labelTitle.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 18)
        labelTitle.textColor = .darkbluegray
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView.snp.leading).offset(27)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
