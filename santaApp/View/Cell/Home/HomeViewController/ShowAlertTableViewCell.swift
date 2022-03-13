//
//  ShowAlertTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/02.
//

import UIKit

class ShowAlertTableViewCell: UITableViewCell {

    static let resueidentifier = "ShowAlertTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    let imageViewProfile : UIImageView = {
        let  imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "1083")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    let labelContent : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 14)
        label.textColor = .darkbluegray
        label.text = "창공에 일월과 가는 이는 교향악이다.이것이 창공에 일월과 가는 이는 교향악이다.이것이"
        label.numberOfLines = 2
        return label
    }()
    
    let labelAgo : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoRegular, size: 13)
        label.textColor = .bluegray
        label.text = "3일전"
        return label
    }()
    
    func setContentView() {
        contentView.addSubview(imageViewProfile)
        imageViewProfile.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(18)
            make.top.equalTo(contentView).offset(15)
            make.width.height.equalTo(40)
        }
        
        contentView.addSubview(labelContent)
        labelContent.snp.makeConstraints { make in
            make.top.equalTo(imageViewProfile)
            make.leading.equalTo(imageViewProfile.snp.trailing).offset(16)
            make.trailing.equalTo(contentView).offset(-25)
        }
        
        contentView.addSubview(labelAgo)
        labelAgo.snp.makeConstraints { make in
            make.leading.equalTo(labelContent)
            make.top.equalTo(labelContent.snp.bottom).offset(6)
        }
    }

}
