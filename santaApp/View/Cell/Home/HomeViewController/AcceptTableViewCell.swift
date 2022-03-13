//
//  AcceptTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/12.
//

import UIKit

class AcceptTableViewCell: UITableViewCell {

    static let resueidentifier = "AcceptTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Content
    let viewContent : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let imageViewisCheck : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let labelExplain : UILabel = {
        let label = UILabel()
        label.textColor = .darkbluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoRegular, size: 14)
        return label
    }()
    let buttonGoPDF : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icHomeArrowRight"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    func setContent() {
        contentView.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        viewContent.addSubview(imageViewisCheck)
        imageViewisCheck.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.centerY.equalTo(contentView)
            make.height.width.equalTo(24)
        }
        
        viewContent.addSubview(labelExplain)
        labelExplain.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(imageViewisCheck.snp.trailing).offset(8)
        }
        
        viewContent.addSubview(buttonGoPDF)
        buttonGoPDF.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.height.equalTo(24)
            make.width.equalTo(50)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
