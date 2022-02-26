//
//  DoubleMessageTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/21.
//

import UIKit

class DoubleMessageTableViewCell: UITableViewCell {
    static let resueidentifier = "DoubleMessageTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //유저 프로필
    let imageViewUserProfile : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "personhome")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 13
        return imageView
    }()
    //댓글 내용과 그 아이디
    let labelMessage : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "등산옹 민영 창공에 일월과 가는 이는 교황악이 이야말로 아니한 불어 눈이 그들을 할것이다. 안녕하세요 CMC 운영국장 지노입니다. 저는 중간점검과 런칭데이 아러러ㅏ라라라라라라라라라라라라ㅏ라라라라라라라라라라라라라라라라라라라라라라라라라라라라라라라라라라라라라라라라ㅏ라라라라ㅏ라라라라라라라라라라라라라랄라ㅏㄹ라라라라라라라라라라라라라라라라라랄라라라라라라"
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoRegular, size: 14)
        label.setTextWithLineHeight(text: label.text, lineHeight: 18)
        label.textColor = .darkbluegray
        return label
    }()
    //댓글 달린 시기
    let labelWhenPostMessage : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoRegular, size: 13)
        label.textColor = .bluegray
        label.text = "1일 전"
        return label
    }()
    
    func setContentView() {
        contentView.addSubview(imageViewUserProfile)
        imageViewUserProfile.snp.makeConstraints { make in
            make.height.width.equalTo(26)
            make.top.equalTo(contentView).offset(19.3)
            make.leading.equalTo(contentView).offset(39)
        }
        
        contentView.addSubview(labelMessage)
        labelMessage.snp.makeConstraints { make in
            make.top.equalTo(imageViewUserProfile)
            make.leading.equalTo(imageViewUserProfile.snp.trailing).offset(11)
            make.trailing.equalTo(contentView).offset(-34)
        }
        
        contentView.addSubview(labelWhenPostMessage)
        labelWhenPostMessage.snp.makeConstraints { make in
            make.leading.equalTo(labelMessage)
            make.top.equalTo(labelMessage.snp.bottom).offset(10)
            make.bottom.equalTo(contentView).offset(-11)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
