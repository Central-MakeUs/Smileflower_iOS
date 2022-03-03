//
//  DetailPostCollectionViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/10.
//

import UIKit

class DetailPostCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: DetailPostCollectionViewCell.self)
    var detailPostViewController : DetailPostViewController?
    var userIdx : Int?
    var postsIdx : Int?
    var flagsIdx : Int?
    var isFlag : Bool = true
    let viewbackgroundView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewbackgroundView.backgroundColor = .lightbluegray
        viewbackgroundView.alpha = 0.15
        viewbackgroundView.layer.cornerRadius = 24
        contentView.addSubview(viewbackgroundView)
        viewbackgroundView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        setImageViewMountain()
        setViewMountain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: 산 사진
    let imageViewMountain = UIImageView()
    let imageViewFlag = UIImageView()
    func setImageViewMountain() {
        imageViewMountain.backgroundColor = UIColor.mainColor
        imageViewMountain.clipsToBounds = true
        imageViewMountain.contentMode = .scaleAspectFill
        imageViewMountain.layer.cornerRadius = 24
        contentView.addSubview(imageViewMountain)
        imageViewMountain.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top)
            make.width.height.equalTo(UIScreen.main.bounds.width - 16)
        }
        imageViewFlag.contentMode = .scaleAspectFit
        contentView.addSubview(imageViewFlag)
        imageViewFlag.snp.makeConstraints { make in
            make.width.equalTo(33.2)
            make.height.equalTo(36)
            make.trailing.equalTo(imageViewMountain.snp.trailing).offset(-21.4)
            make.top.equalTo(imageViewMountain.snp.top).offset(26.4)
        }
    }
    //MARK : 산정보
    let viewMountain = UIView()
    let imageViewPosition = UIImageView()
    let labelMountainName = UILabel()
    let labelDateAndTime = UILabel()
    let buttonMore = UIButton()
    func setViewMountain() {
        contentView.addSubview(viewMountain)
        viewMountain.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(contentView)
            make.top.equalTo(imageViewMountain.snp.bottom)
        }
        imageViewPosition.image = UIImage(named: "position@3x")
        viewMountain.addSubview(imageViewPosition)
        imageViewPosition.snp.makeConstraints { make in
            make.centerY.equalTo(viewMountain.snp.centerY)
            make.leading.equalTo(16)
            make.width.equalTo(22.4)
            make.height.equalTo(26.7)
        }
        labelMountainName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 28)
        labelMountainName.textColor = .darkbluegray
        viewMountain.addSubview(labelMountainName)
        labelMountainName.snp.makeConstraints { make in
            make.centerY.equalTo(viewMountain.snp.centerY)
            make.leading.equalTo(imageViewPosition.snp.trailing).offset(9)
        }
        labelDateAndTime.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
        labelDateAndTime.numberOfLines = 2
        labelDateAndTime.textColor = .titleColorGray
        labelDateAndTime.textAlignment = .left
        viewMountain.addSubview(labelDateAndTime)
        labelDateAndTime.snp.makeConstraints { make in
            make.centerY.equalTo(viewMountain.snp.centerY)
            make.leading.equalTo(labelMountainName.snp.trailing).offset(6.1)
        }
        buttonMore.setImage(UIImage(named: "more@3x"), for: .normal)
        buttonMore.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        buttonMore.addTarget(self, action: #selector(actionMore), for: .touchUpInside)
        viewMountain.addSubview(buttonMore)
        buttonMore.snp.makeConstraints { make in
            make.centerY.equalTo(imageViewPosition.snp.centerY)
            make.trailing.equalTo(viewMountain.snp.trailing).offset(-11)
            make.width.height.equalTo(42)
        }
    }
    @objc func actionMore() {
            self.showAlert(style: .actionSheet)
    }
    func showAlert(style: UIAlertController.Style) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: style)
        let logout = UIAlertAction(title: "게시물 삭제", style: .default) { action in
            
            if self.isFlag {
                if let useridx = self.userIdx, let flagidx = self.flagsIdx {
                    FlagsDeleteDataManager().apiprofileuseridxflagsflagIdx(flagidx, self)
                }
            }
            else {
                if let useridx = self.userIdx, let postidx = self.postsIdx {
                    PostsDeleteDataManager().apiprofileuseridxpicturespictures(postidx, self)
                }
            }
        }
        logout.setValue(UIColor.red, forKey: "titleTextColor")
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        cancel.setValue(UIColor.darkbluegray, forKey: "titleTextColor")
        alert.addAction(logout)
        alert.addAction(cancel)
        detailPostViewController?.present(alert, animated: true, completion: nil)
    }
}

extension DetailPostCollectionViewCell {
    func successDataApiDeletePosts() {
        self.detailPostViewController?.viewWillAppear(false)
        self.detailPostViewController?.carouselCollectionView.reloadData()
    }
    func failureDataApiDelete(_ message : String) {
        detailPostViewController?.presentAlert(title: message)
    }
}
