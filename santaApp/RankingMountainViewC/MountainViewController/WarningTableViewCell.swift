//
//  WarningTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/08.
//

import UIKit

class WarningTableViewCell: UITableViewCell {
    static let identifier = "WarningTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageViewSetWarning()
        labelSetWarning()
        labelSetWarningExplain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //MARK: 위치 이미지
    let imageViewWarning = UIImageView()
    func imageViewSetWarning() {
        imageViewWarning.image = UIImage(named: "Warning@3x")
        contentView.addSubview(imageViewWarning)
        imageViewWarning.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(25)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
    }
    //MARK: 위치 라벨
    let labelWarning = UILabel()
    func labelSetWarning() {
        labelWarning.text = "주의\n사항"
        labelWarning.numberOfLines = 2
        labelWarning.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelWarning.textColor = .titleColorGray
        contentView.addSubview(labelWarning)
        labelWarning.snp.makeConstraints { make in
            make.centerY.equalTo(imageViewWarning.snp.centerY)
            make.leading.equalTo(imageViewWarning.snp.trailing).offset(3)
        }
    }
    //MARK: 산 주소
    let labelWarningExplain = UILabel()
    func labelSetWarningExplain() {
        labelWarningExplain.text = "1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n"
        labelWarningExplain.numberOfLines = 100
        labelWarningExplain.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        contentView.addSubview(labelWarningExplain)
        labelWarningExplain.snp.makeConstraints { make in
            make.top.equalTo(labelWarning.snp.top)
            make.leading.equalTo(labelWarning.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
        }
        
    }
}
