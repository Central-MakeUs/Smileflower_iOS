//
//  DetailConquerCollectionViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2022/01/25.
//

import UIKit
import SwiftUI

class DetailConquerCollectionViewCell: UICollectionViewCell {
    static let resueidentifier = "DetailConquerCollectionViewCell"
    var preViewController : DetailConquerViewController?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTopFeed()
        setFeedBottom()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isgradient = false
    
    override func layoutSubviews() {
        if viewFeedGradient.layer.sublayers == nil {
            self.viewFeedGradient.setGradient(color1: UIColor(hex: 0x1c3240, alpha: 0), color2: UIColor(hex: 0x1c3240, alpha: 0.38))
        } else {
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.colors = [UIColor(hex: 0x1c3240, alpha: 0).cgColor,UIColor(hex: 0x1c3240, alpha: 0.38).cgColor]
            gradient.locations = [0.0 , 1.0]
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.frame = bounds
            self.viewFeedGradient.layer.sublayers![0] = gradient
        }
       super.layoutSubviews()
    }
    
   
    
    let viewContent = UIView()
    // MARK: 피드 상단 사진
    // 피드 큰틀
    let viewTopFeed : UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightbluegray.cgColor
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    // 유저 이미지 사진
    let imageViewUserProfile : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.backgroundColor = .mainColor
        return imageView
    }()
    // 유저 레벨
    let labelUserLv : UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "Lv.0", lineHeight: 13)
        label.textColor = .bluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 11)
        return label
    }()
    // 유저 산타
    let labelUserName : UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "산타", lineHeight: 17)
        label.textColor = .darkbluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 14)
        return label
    }()
    // 더보기 버튼
    let buttonMore : UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.layer.zPosition = 999
        button.setImage(UIImage(named: "icFeedMore"), for: .normal)
        return button
    }()
    
    func showAlert(style: UIAlertController.Style) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: style)
        let logout = UIAlertAction(title: "신고하기", style: .default) { action in
            
        }
        logout.setValue(UIColor.red, forKey: "titleTextColor")
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        cancel.setValue(UIColor.darkbluegray, forKey: "titleTextColor")
        alert.addAction(logout)
        alert.addAction(cancel)
        preViewController?.present(alert, animated: true, completion: nil)
    }
    
    @objc func actionReport() {
        print("click")
        showAlert(style: .actionSheet)
    }
    // 피드 사진
    let imageViewFeed : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    let viewFeedGradient : UIView = {
        let view = UIView()
        return view
    }()
    //MARK: 이미지 안에 들어갈 텍스트들
    let imageViewPosition : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icHikingMap")
        return imageView
    }()
    let labelMountainName : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 14)
        label.addCharacterSpacing(kernValue: -0.42)
        label.text = "인왕산"
        return label
    }()
    let imageViewMountainHeight : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icFeedMountainWhite")
        return imageView
    }()
    let labelMountainHeight : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 15)
        label.addCharacterSpacing(kernValue: -0.15)
        label.text = "295m"
        return label
    }()
    let labelMountainTime : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 13)
        label.addCharacterSpacing(kernValue: -0.15)
        label.text = "2021년 6월28일 오후 2:18"
        return label
    }()
    
    //MARK: 상단 피드 셋
    func setTopFeed() {
        contentView.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        viewContent.addSubview(viewTopFeed)
        viewTopFeed.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(283)
        }
        
        viewTopFeed.addSubview(imageViewUserProfile)
        imageViewUserProfile.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.leading.equalTo(self).offset(12.7)
            make.top.equalTo(self).offset(9)
        }
        
        viewTopFeed.addSubview(labelUserLv)
        labelUserLv.snp.makeConstraints { make in
            make.top.equalTo(self).offset(12)
            make.leading.equalTo(imageViewUserProfile.snp.trailing).offset(8)
        }
        
        viewTopFeed.addSubview(labelUserName)
        labelUserName.snp.makeConstraints { make in
            make.top.equalTo(labelUserLv.snp.bottom)
            make.leading.equalTo(labelUserLv)
        }
        
        buttonMore.addTarget(self, action: #selector(actionReport), for: .touchUpInside)
        viewTopFeed.addSubview(buttonMore)
        buttonMore.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.trailing.equalTo(viewTopFeed).offset(-12)
            make.top.equalTo(viewTopFeed).offset(12)
        }
        
        viewTopFeed.addSubview(imageViewFeed)
        imageViewFeed.snp.makeConstraints { make in
            make.top.equalTo(imageViewUserProfile.snp.bottom).offset(7)
            make.trailing.leading.bottom.equalTo(viewTopFeed)
        }
        
        imageViewFeed.addSubview(viewFeedGradient)
        viewFeedGradient.snp.makeConstraints { make in
            make.edges.equalTo(imageViewFeed)
        }
        
        imageViewFeed.addSubview(imageViewPosition)
        imageViewPosition.snp.makeConstraints { make in
            make.height.width.equalTo(15)
            make.leading.equalTo(self).offset(16)
            make.bottom.equalTo(imageViewFeed).offset(-15.3)
        }
        
        imageViewFeed.addSubview(labelMountainName)
        labelMountainName.snp.makeConstraints { make in
            make.centerY.equalTo(imageViewPosition)
            make.leading.equalTo(imageViewPosition.snp.trailing).offset(2)
        }
        
        imageViewFeed.addSubview(imageViewMountainHeight)
        imageViewMountainHeight.snp.makeConstraints { make in
            make.centerY.equalTo(imageViewPosition)
            make.leading.equalTo(labelMountainName.snp.trailing).offset(8)
            make.height.width.equalTo(15)
        }
        
        imageViewFeed.addSubview(labelMountainHeight)
        labelMountainHeight.snp.makeConstraints { make in
            make.centerY.equalTo(imageViewPosition)
            make.leading.equalTo(imageViewMountainHeight.snp.trailing).offset(2)
        }
        
        imageViewFeed.addSubview(labelMountainTime)
        labelMountainTime.snp.makeConstraints { make in
            make.centerY.equalTo(imageViewPosition)
            make.trailing.equalTo(self).offset(-16)
        }
    }
    
    //MARK: 하단 피드 게시글
    let buttonisHeart : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heartUnSelected@3x"), for: .normal)
        button.setImage(UIImage(named: "heartSelected@3x"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(actionIsHeart), for: .touchUpInside)
        return button
    }()
    @objc func actionIsHeart() {
        if buttonisHeart.isSelected {
            buttonisHeart.isSelected = false
        } else {
            buttonisHeart.isSelected = true
        }
    }
    let labelHowManyHeart : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 13)
        label.textColor = .bluegray
        label.text = "0"
        return label
    }()
    let buttonMessage : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icHomeChatOutline"), for: .normal)
        return button
    }()
    let labelHowManyMessage : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 13)
        label.textColor = .bluegray
        label.text = "0"
        return label
    }()
    let imageViewMessageUserProfile : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 17.5
        imageView.backgroundColor = .mainColor
        return imageView
    }()
    
    var UserNameString : String = ""
    var UserMessageString : String = ""
    
    let labelFeedMessage : UILabel = {
        let label = UILabel()
        label.textColor = .darkbluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoRegular, size: 14)
        label.numberOfLines = 2
        return label
    }()
    let buttonGoDetailMessage : UIButton = {
        let button = UIButton()
        button.setTitle("2개의 댓글 모두 보기", for: .normal)
        button.setTitleColor(.lightbluegray, for: .normal)
        button.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoRegular, size: 14)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    func setFeedBottom() {
        viewContent.addSubview(buttonisHeart)
        buttonisHeart.snp.makeConstraints { make in
            make.leading.equalTo(viewTopFeed)
            make.top.equalTo(viewTopFeed.snp.bottom).offset(10)
            make.width.height.equalTo(18.5)
        }
        
        viewContent.addSubview(labelHowManyHeart)
        labelHowManyHeart.snp.makeConstraints { make in
            make.centerY.equalTo(buttonisHeart)
            make.leading.equalTo(buttonisHeart.snp.trailing).offset(2)
        }
        viewContent.addSubview(buttonMessage)
        buttonMessage.snp.makeConstraints { make in
            make.centerY.equalTo(buttonisHeart)
            make.leading.equalTo(labelHowManyHeart.snp.trailing).offset(7)
            make.width.height.equalTo(18.5)
        }
        
        viewContent.addSubview(labelHowManyMessage)
        labelHowManyMessage.snp.makeConstraints { make in
            make.centerY.equalTo(buttonisHeart)
            make.leading.equalTo(buttonMessage.snp.trailing).offset(2)
        }
        
        viewContent.addSubview(imageViewMessageUserProfile)
        imageViewMessageUserProfile.snp.makeConstraints { make in
            make.leading.equalTo(viewTopFeed)
            make.width.height.equalTo(35)
            make.top.equalTo(buttonisHeart.snp.bottom).offset(14.7)
        }
        
        labelFeedMessage.text = "\(UserNameString) \(UserMessageString)"
        
        let idFont = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 14)
        let attributedStr = NSMutableAttributedString(string: labelFeedMessage.text ?? "")
        attributedStr.addAttribute(.font, value: idFont, range: (labelFeedMessage.text as! NSString).range(of: UserNameString))
        labelFeedMessage.attributedText = attributedStr
        
        viewContent.addSubview(labelFeedMessage)
        labelFeedMessage.snp.makeConstraints { make in
            make.leading.equalTo(imageViewMessageUserProfile.snp.trailing).offset(10)
            make.trailing.equalTo(viewContent.snp.trailing).offset(-17)
            make.top.equalTo(imageViewMessageUserProfile)
        }
        
        viewContent.addSubview(buttonGoDetailMessage)
        buttonGoDetailMessage.snp.makeConstraints { make in
            make.leading.trailing.equalTo(labelFeedMessage)
            make.top.equalTo(labelFeedMessage.snp.bottom)
        }
    }
}
