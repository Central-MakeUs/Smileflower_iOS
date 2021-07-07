//
//  CourseTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/07.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    static let identifier = "CourseTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buttonSetCourse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: 코스 버튼
    let buttonCourse = UIButton()
    let labelDistanse = UILabel()
    let labelTimes = UILabel()

    func buttonSetCourse() {
        buttonCourse.layer.cornerRadius = 13
        buttonCourse.layer.borderWidth = 1
        buttonCourse.layer.borderColor = UIColor.mainColor.cgColor
        buttonCourse.setTitleColor(.mainColor, for: .normal)
        buttonCourse.titleLabel?.textColor = .mainColor
        contentView.addSubview(buttonCourse)
        buttonCourse.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(contentView)
            make.width.equalTo(71)
        }
        let viewTime = UIView()
        viewTime.backgroundColor = UIColor(hex: 0xc1cad0, alpha: 0.3)
        viewTime.layer.cornerRadius = 13
        contentView.addSubview(viewTime)
        viewTime.snp.makeConstraints { make in
            make.trailing.top.bottom.equalTo(contentView)
            make.width.equalTo(146)
        }
        //MARK: 거리
        labelDistanse.textColor = .titleColorGray
        labelDistanse.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 16)
        viewTime.addSubview(labelDistanse)
        labelDistanse.snp.makeConstraints { make in
            make.leading.equalTo(viewTime.snp.leading).offset(17)
            make.centerY.equalTo(viewTime.snp.centerY)
            make.width.equalTo(43)
        }
        //MARK: 등산 시간
        labelTimes.textColor = .titleColorGray
        labelTimes.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 16)
        viewTime.addSubview(labelTimes)
        labelTimes.snp.makeConstraints { make in
            make.leading.equalTo(labelDistanse.snp.trailing).offset(15)
            make.centerY.equalTo(viewTime.snp.centerY)
            make.width.equalTo(54)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
