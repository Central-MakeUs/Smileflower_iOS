//
//  ConquerImageCollectionViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/12/22.
//

import UIKit

class ConquerImageCollectionViewCell: UICollectionViewCell {
    static let resueidentifier = "ConquerImageCollectionViewCell"
    let viewContent : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // 유저 이미지
    let imageViewUserProfile : UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 11.2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightbluegray
        return imageView
    }()
    // 유저 레벨
    let labelUserLv : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 9)
        label.textColor = .bluegray
        label.setTextWithLineHeight(text: label.text, lineHeight: 11)
        return label
    }()
    // 유저 닉네임
    let labelUserNickName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 11)
        label.textColor = .darkbluegray
        label.setTextWithLineHeight(text: label.text, lineHeight: 13)
        return label
    }()
    // 댓글 수
    let labelPostMessageNumber : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 11)
        label.textColor = .lightbluegray
        label.setTextWithLineHeight(text: label.text, lineHeight: 13)
        label.text = "0"
        return label
    }()
    // 댓글 이미지
    let imageViewPostMessage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icHomeChatOutline")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // 좋아요 수
    let labelPostLikeNumber : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 11)
        label.textColor = .lightbluegray
        label.setTextWithLineHeight(text: label.text, lineHeight: 13)
        label.text = "0"
        return label
    }()
    // 좋아요 이미지
    let imageViewLike : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icHomeLikeOutline")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // 정복 이미지
    let imageViewUserConquer : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightbluegray
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    //MARK: 뷰 구성
    func setContentView() {
        contentView.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        viewContent.addSubview(imageViewUserProfile)
        imageViewUserProfile.snp.makeConstraints { make in
            make.width.height.equalTo(22.4)
            make.top.equalTo(viewContent).offset(7)
            make.leading.equalTo(viewContent).offset(8.6)
        }
        
        viewContent.addSubview(labelUserLv)
        labelUserLv.snp.makeConstraints { make in
            make.leading.equalTo(imageViewUserProfile.snp.trailing).offset(8)
            make.top.equalTo(viewContent).offset(9)
        }
        
        viewContent.addSubview(labelUserNickName)
        labelUserNickName.snp.makeConstraints { make in
            make.leading.equalTo(labelUserLv)
            make.top.equalTo(labelUserLv.snp.bottom).offset(-2)
            make.trailing.equalTo(viewContent).offset(-118)
        }
        
        viewContent.addSubview(labelPostMessageNumber)
        labelPostMessageNumber.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-10.1)
            make.top.equalTo(viewContent).offset(13)
        }
        
        viewContent.addSubview(imageViewPostMessage)
        imageViewPostMessage.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.top.equalTo(viewContent).offset(11.6)
            make.trailing.equalTo(labelPostMessageNumber.snp.leading).offset(-3.9)
        }
        
        viewContent.addSubview(labelPostLikeNumber)
        labelPostLikeNumber.snp.makeConstraints { make in
            make.trailing.equalTo(imageViewPostMessage.snp.leading).offset(-3.9)
            make.top.equalTo(viewContent).offset(13)
        }
        
        viewContent.addSubview(imageViewLike)
        imageViewLike.snp.makeConstraints { make in
            make.trailing.equalTo(labelPostLikeNumber.snp.leading).offset(-2.9)
            make.top.equalTo(viewContent).offset(12)
            make.width.height.equalTo(15)
        }
        
        viewContent.addSubview(imageViewUserConquer)
        imageViewUserConquer.snp.makeConstraints { make in
            make.top.equalTo(imageViewUserProfile.snp.bottom).offset(5)
            make.trailing.leading.bottom.equalTo(viewContent)
        }
    }
}
