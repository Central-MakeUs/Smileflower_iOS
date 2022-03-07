//
//  MessageTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2022/02/20.
//

import UIKit

class HaveCommentsTableViewCell: UITableViewCell {
    static let resueidentifier = "HaveCommentsTableViewCell"
    var comments : Int = 0
    var commentIndex = 0
    var commentUserId = ""
    var previoutViewcontroller : DetailMessageViewController?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setContentView()
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //댓글 쓴 유저의 이미지
    let imageViewUserProfile : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "personhome")
        imageView.layer.cornerRadius = 17.5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    //더 보기 버튼
    let buttonMore : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icFeedMore"), for: .normal)
        return button
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
    //답글 달기 버튼
    let buttonDoDoubleMessage : UIButton = {
        let button = UIButton()
        button.setTitle("답글 달기", for: .normal)
        button.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoRegular, size: 13)
        button.setTitleColor(.bluegray, for: .normal)
        return button
    }()
    @objc func actionDoubleMessage(button:UIButton) {
        previoutViewcontroller?.textFieldWriteMessage.becomeFirstResponder()
        previoutViewcontroller?.viewDoubleComment.alpha = 0.2
        previoutViewcontroller?.commentIndex = commentIndex
    }
    //답글 보기
    let viewButtonBackView : UIView = {
        let view = UIView()
        return view
    }()
    let buttonSeeComments : UIButton = {
        let button = UIButton()
        return button
    }()
    let labelSeeComments : UILabel = {
        let label = UILabel()
        label.text = "답글보기"
        label.textColor = .bluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 13)
        return label
    }()
    let imageViewUpDown : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icChatArrowDown")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    func setContentView() {
        contentView.addSubview(imageViewUserProfile)
        imageViewUserProfile.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.leading.equalTo(contentView).offset(20)
            make.top.equalTo(contentView).offset(18)
        }
        
        contentView.addSubview(buttonMore)
        buttonMore.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-18)
            make.top.equalTo(contentView).offset(18)
            make.width.height.equalTo(18)
        }
        
        contentView.addSubview(labelMessage)
        labelMessage.snp.makeConstraints { make in
            make.leading.equalTo(imageViewUserProfile.snp.trailing).offset(10)
            make.trailing.equalTo(buttonMore.snp.leading).offset(-10)
            make.top.equalTo(imageViewUserProfile)
        }
        
        contentView.addSubview(labelWhenPostMessage)
        labelWhenPostMessage.snp.makeConstraints { make in
            make.leading.equalTo(labelMessage)
            make.top.equalTo(labelMessage.snp.bottom).offset(10)
        }
        
        buttonDoDoubleMessage.addTarget(self, action: #selector(actionDoubleMessage(button:)), for: .touchUpInside)
        contentView.addSubview(buttonDoDoubleMessage)
        buttonDoDoubleMessage.snp.makeConstraints { make in
            make.top.equalTo(labelMessage.snp.bottom).offset(10)
            make.leading.equalTo(labelWhenPostMessage.snp.trailing).offset(10)
        }
        
        contentView.addSubview(viewButtonBackView)
        viewButtonBackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(labelWhenPostMessage.snp.bottom).offset(11)
            make.top.equalTo(buttonDoDoubleMessage.snp.bottom).offset(11)
            make.height.equalTo(28)
            make.bottom.equalTo(contentView)
        }
        
        viewButtonBackView.addSubview(buttonSeeComments)
        buttonSeeComments.snp.makeConstraints { make in
            make.edges.equalTo(viewButtonBackView)
        }

        viewButtonBackView.addSubview(labelSeeComments)
        labelSeeComments.snp.makeConstraints { make in
            make.centerY.equalTo(viewButtonBackView)
            make.leading.equalTo(labelMessage)
        }

        viewButtonBackView.addSubview(imageViewUpDown)
        imageViewUpDown.snp.makeConstraints { make in
            make.centerY.equalTo(viewButtonBackView)
            make.leading.equalTo(labelSeeComments.snp.trailing).offset(2)
            make.height.width.equalTo(14)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
