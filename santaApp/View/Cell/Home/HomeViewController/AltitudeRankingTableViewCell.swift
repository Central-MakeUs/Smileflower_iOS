//
//  AltitudeRankingTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/12/22.
//

import UIKit

class AltitudeRankingTableViewCell: UITableViewCell {

    static let resueidentifier = "AltitudeRankingTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setTabelViewContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: 등 수 변수
    let labelGrade : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 13)
        label.setTextWithLineHeight(text: label.text, lineHeight: 20)
        label.textColor = .darkbluegray
        label.textAlignment = .center
        return label
    }()
    
    let imageViewUserImage : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.paleblue97.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 17.5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let imageViewTopGrade : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let labelUserLv : UILabel = {
        let label = UILabel()
        label.text = "Lv.10"
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
        label.setTextWithLineHeight(text: label.text, lineHeight: 15)
        label.textColor = .bluegray
        return label
    }()
    
    let labelUserNickName : UILabel = {
        let label = UILabel()
        label.text = "등산왕민영"
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 15)
        label.setTextWithLineHeight(text: label.text, lineHeight: 19)
        label.textColor = .darkbluegray
        return label
    }()
    
    let viewConquerAgo : UIView = {
       let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.bluegray.cgColor
        view.layer.cornerRadius = 7
        return view
    }()
    
    let labelConquerAgo : UILabel = {
        let label = UILabel()
        label.text = "3일전"
        label.textColor = .bluegray
        label.textAlignment = .center
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 11)
        return label
    }()
    
    let labelMountainHeight : UILabel = {
        let label = UILabel()
        label.text = "2km"
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)
        label.setTextWithLineHeight(text: label.text, lineHeight: 19)
        label.textColor = .darkbluegray
        label.textAlignment = .center
        return label
    }()
    
    //MARK: Set 등 수
    func setTabelViewContent() {
        self.addSubview(labelGrade)
        labelGrade.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(7)
            make.centerY.equalTo(self).offset(-2.5)
            make.width.equalTo(33)
        }
        
        self.addSubview(imageViewUserImage)
        imageViewUserImage.snp.makeConstraints { make in
            make.leading.equalTo(labelGrade.snp.trailing).offset(2)
            make.centerY.equalTo(labelGrade)
            make.width.height.equalTo(35)
        }
        
        self.addSubview(imageViewTopGrade)
        imageViewTopGrade.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(18)
            make.centerX.equalTo(imageViewUserImage)
            make.top.equalTo(imageViewUserImage).offset(25)
        }
        
        self.addSubview(labelUserLv)
        labelUserLv.snp.makeConstraints { make in
            make.leading.equalTo(imageViewUserImage.snp.trailing).offset(20)
            make.top.equalTo(self).offset(10)
        }
        
        self.addSubview(labelUserNickName)
        labelUserNickName.snp.makeConstraints { make in
            make.leading.equalTo(labelUserLv)
            make.top.equalTo(labelUserLv.snp.bottom)
        }
        
        self.addSubview(viewConquerAgo)
        viewConquerAgo.snp.makeConstraints { make in
            make.width.equalTo(35)
            make.height.equalTo(14)
            make.top.equalTo(self).offset(9)
            make.trailing.equalTo(self).offset(-28.8)
        }
        
        viewConquerAgo.addSubview(labelConquerAgo)
        labelConquerAgo.snp.makeConstraints { make in
            make.edges.equalTo(viewConquerAgo)
        }
        
        self.addSubview(labelMountainHeight)
        labelMountainHeight.snp.makeConstraints { make in
            make.top.equalTo(labelConquerAgo.snp.bottom).offset(2.2)
            make.centerX.equalTo(viewConquerAgo)
        }
    }
}
