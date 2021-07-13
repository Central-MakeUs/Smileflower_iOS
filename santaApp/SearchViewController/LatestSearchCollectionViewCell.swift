//
//  LatestSearchCollectionViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/11.
//

import UIKit

class LatestSearchCollectionViewCell: UICollectionViewCell {
    static let identifier = "LatestSearchCollectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackground()
        setLabel()
        buttonSet()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MAKR: 전체 벡그라운드
    let view = UIView()
    func setBackground() {
        view.backgroundColor = UIColor(hex: 0xdfe5ed)
        view.alpha = 0.51
        view.layer.cornerRadius = 18
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    //MARK: 검색어
    let label = UILabel()
    func setLabel() {
        label.textColor = .darkbluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 14)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.width.equalTo(37)
        }
    }
    //MARK: 삭제 버튼
    let buttonDelete = UIButton()
    func buttonSet() {
        buttonDelete.setImage(UIImage(named: "icSearchCancel@3x"), for: .normal)
        contentView.addSubview(buttonDelete)
        buttonDelete.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(label.snp.trailing).offset(4)
            make.width.height.equalTo(18)
        }
    }
}
