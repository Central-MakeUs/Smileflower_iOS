//
//  CompleteViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/02.
//

import UIKit

class CompleteViewController : BaseViewController, UINavigationBarDelegate  {
    let imageViewComplete = UIImageView()
    let buttonGoConquerMountainView = UIButton()
    let viewRank = UIView()
    let viewMaster = UIView()
    let imageViewBackground = UIImageView()
    
    // MARK: 최하단 랭킹 뷰 변수들
    let labelRankTitle = UILabel()
    let stackViewRackView = UIStackView()
    let viewMasterRankView = UIView()
    let viewUserRankView = UIView()
    
    let labelMasterRank = UILabel()
    let labelUserRank = UILabel()
    
    let imageViewMasterRank = UIImageView()
    let imageViewUserRank = UIImageView()
    
    let imageViewMasterProfile = UIImageView()
    let imageViewUserProfile = UIImageView()
    
    let labelMasterLV = UILabel()
    let labelUserLV = UILabel()
    
    let labelMasterName = UILabel()
    let labelUserName = UILabel()
    
    let labelMasterTimes = UILabel()
    let labelUsertimes = UILabel()
    
    let imageViewFlag = UIImageView()
    let imageViewFlag2 = UIImageView()
    
    
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .titleColorGray
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradient(color1: UIColor(hex: 0x9ac7ff), color2: UIColor(hex: 0xffffff))
        navigationBarSet()
        imageViewSetBackground()
        viewSetRank()
        viewSetRankingView()
        buttonSetGoConquerMountainView()
        imageViewSetComplete()
        
        
    }
    // MARK: 네비게이션 바
    func navigationBarSet() {
        let height: CGFloat = 75
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.clear
        navbar.delegate = self

        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = self.leftButton
        navbar.items = [navItem]
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.layoutIfNeeded()
        view.addSubview(navbar)
    }
    @objc func actionBackButton(_ sender : Any) {
        self.changeRootViewController(BaseTabbarController())
    }
    // MARK: 배경
    func imageViewSetBackground() {
        imageViewBackground.image = UIImage(named: "ConquerBackground@3x")
        imageViewBackground.contentMode = .center
        view.addSubview(imageViewBackground)
        imageViewBackground.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-187.9)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(352.9)
        }
    }
    // MARK: 정복 이미지
    func imageViewSetComplete() {
        imageViewComplete.image = UIImage(named: "completeMountain")
        imageViewComplete.contentMode = .scaleAspectFill
        view.addSubview(imageViewComplete)
        
        // 중간에서 얼마나 떨어져 있을까요?
        imageViewComplete.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(buttonGoConquerMountainView.snp.top).offset(-15.4)
            make.width.equalTo(261.3)
            make.height.equalTo(116.9)
        }
    }
    // MARK: 내가 정복한 산 보러가기
    func buttonSetGoConquerMountainView() {
        buttonGoConquerMountainView.setTitle("내가 정복한 산 보러가기", for: .normal)
        buttonGoConquerMountainView.backgroundColor = UIColor(hex: 0x1C3240)
        buttonGoConquerMountainView.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 16)
        buttonGoConquerMountainView.addTarget(self, action: #selector(actionGoConquerMountainView), for: .touchUpInside)
        view.addSubview(buttonGoConquerMountainView)
        buttonGoConquerMountainView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(237)
            make.height.equalTo(50)
            make.bottom.equalTo(viewRank.snp.top).offset(-21)
        }
        buttonGoConquerMountainView.layer.cornerRadius = 25
    }
    @objc func actionGoConquerMountainView() {
        let nextVC = DetailPosteViewController()
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
    
    // MARK: 최하단 랭킹 뷰
    func viewSetRank() {
        viewRank.roundCorners(cornerRadius: 28, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        viewRank.layer.shadowColor = UIColor(hex: 0x808CA0).cgColor
        viewRank.layer.shadowOpacity = 0.3
        viewRank.layer.shadowOffset = CGSize(width: 0, height: 8)
        viewRank.layer.shadowRadius = 0
        viewRank.backgroundColor = .white
        view.addSubview(viewRank)
        
        viewRank.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(244)
        }
    }
    // MARK: 랭킹 마스터 뷰
    func viewSetRankingView() {
        
        labelRankTitle.text = "랭킹"
        labelRankTitle.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)
        labelRankTitle.textAlignment = .center
        labelRankTitle.textColor = UIColor.darkbluegray
        viewRank.addSubview(labelRankTitle)
        
        labelRankTitle.snp.makeConstraints { make in
            make.centerX.equalTo(viewRank.snp.centerX)
            make.top.equalTo(viewRank.snp.top).offset(17)
        }
        
        self.stackViewRackView.axis = .vertical
        self.stackViewRackView.alignment = .fill
        self.stackViewRackView.distribution = .fillEqually
        self.stackViewRackView.spacing = 0.2
        self.stackViewRackView.backgroundColor = UIColor(hex: 0x707070, alpha: 0.51)
        viewRank.addSubview(stackViewRackView)
        
        stackViewRackView.snp.makeConstraints { make in
            make.top.equalTo(labelRankTitle.snp.bottom).offset(2)
            make.width.equalTo(343)
            make.height.equalTo(180)
            make.centerX.equalTo(viewRank.snp.centerX)
        }
        
        viewSetMasterRankView()
        viewMasterRankView.backgroundColor = .white
        viewSetUserRankView()
        viewUserRankView.backgroundColor = .white
    
        stackViewRackView.addArrangedSubview(viewMasterRankView)
        stackViewRackView.addArrangedSubview(viewUserRankView)
    }
    func viewSetMasterRankView() {
        labelMasterRank.text = "1"
        labelMasterRank.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 19)
        labelMasterRank.textAlignment = .center
        viewMasterRankView.addSubview(labelMasterRank)
        labelMasterRank.snp.makeConstraints { make in
            make.centerY.equalTo(viewMasterRankView.snp.centerY)
            make.leading.equalTo(viewMasterRankView.snp.leading).offset(5)
            make.width.equalTo(34)
        }
        
        let resizeImageMasterRank = UIImage(named: "masterView@3x")
//        resizeImageMasterRank?.resize(size: CGSize(width: 66.4, height: 72.9))
        imageViewMasterRank.image = resizeImageMasterRank
        viewMasterRankView.addSubview(imageViewMasterRank)
        imageViewMasterRank.snp.makeConstraints { make in
            make.centerY.equalTo(viewMasterRankView.snp.centerY)
            make.leading.equalTo(labelMasterRank.snp.trailing)
            make.width.equalTo(82.5)
            make.height.equalTo(103)
        }
        let imageViewMaster = UIImageView()
        imageViewMaster.image = UIImage(named: "master@3x")
        imageViewMaster.contentMode = .scaleAspectFit
        imageViewMasterRank.addSubview(imageViewMaster)
        imageViewMaster.snp.makeConstraints { make in
            make.centerX.equalTo(imageViewMasterRank.snp.centerX)
            make.top.equalTo(imageViewMasterRank.snp.top).offset(54.5)
            make.width.equalTo(53.5)
            make.height.equalTo(16.2)
        }
        
        labelMasterLV.text = "LV.9"
        labelMasterLV.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
        labelMasterLV.setTextWithLineHeight(text: labelMasterLV.text, lineHeight: 15)
        labelMasterLV.textColor = .titleColorGray
        viewMasterRankView.addSubview(labelMasterLV)
        labelMasterLV.snp.makeConstraints { make in
            make.top.equalTo(viewMasterRankView.snp.top).offset(35)
            make.leading.equalTo(imageViewMasterRank.snp.trailing).offset(1.6)
        }
        
        labelMasterName.text = "코트"
        labelMasterName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 18)
        labelMasterName.setTextWithLineHeight(text: labelMasterName.text, lineHeight: 21)
        labelMasterName.addCharacterSpacing(kernValue: -0.36)
        labelMasterName.textColor = .darkbluegray
        viewMasterRankView.addSubview(labelMasterName)
        labelMasterName.snp.makeConstraints { make in
            make.leading.equalTo(labelMasterLV.snp.leading)
            make.top.equalTo(labelMasterLV.snp.bottom)
        }
        
        imageViewFlag.image = UIImage(named: "FlagIconMainColor@3x")
        imageViewFlag.contentMode = .scaleAspectFit
        viewMasterRankView.addSubview(imageViewFlag)
        imageViewFlag.snp.makeConstraints { make in
            make.trailing.equalTo(viewMasterRankView.snp.trailing).offset(-16.7)
            make.centerY.equalTo(labelMasterName.snp.centerY).offset(-2)
            make.width.equalTo(15.3)
            make.height.equalTo(17.3)
        }

        labelMasterTimes.text = "99회"
        labelMasterTimes.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 20)
        labelMasterTimes.textColor = .mainColor
        labelMasterTimes.textAlignment = .right
        viewMasterRankView.addSubview(labelMasterTimes)
        labelMasterTimes.snp.makeConstraints { make in
            make.trailing.equalTo(imageViewFlag.snp.leading).offset(-6.2)
            make.centerY.equalTo(labelMasterName.snp.centerY)
        }
    }
    func viewSetUserRankView() {
        labelUserRank.text = "20"
        labelUserRank.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 19)
        labelUserRank.textAlignment = .center
        viewUserRankView.addSubview(labelUserRank)
        labelUserRank.snp.makeConstraints { make in
            make.centerY.equalTo(viewUserRankView.snp.centerY)
            make.leading.equalTo(viewUserRankView.snp.leading).offset(5)
            make.width.equalTo(34)
        }
//
        imageViewUserRank.image =  UIImage(named: "profileView@3x")
        imageViewUserRank.contentMode = .scaleAspectFit
        viewUserRankView.addSubview(imageViewUserRank)
        imageViewUserRank.snp.makeConstraints { make in
            make.centerY.equalTo(viewUserRankView.snp.centerY)
            make.leading.equalTo(labelUserRank.snp.trailing).offset(11.7)
            make.width.equalTo(63.8)
            make.height.equalTo(83)
        }

        labelUserLV.text = "LV.5"
        labelUserLV.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
        labelUserLV.textColor = .titleColorGray
        viewUserRankView.addSubview(labelUserLV)
        labelUserLV.snp.makeConstraints { make in
            make.centerY.equalTo(viewUserRankView.snp.centerY)
            make.leading.equalTo(imageViewUserRank.snp.trailing).offset(9.1)
        }

        labelUserName.text = "에스핀"
        labelUserName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 18)
        labelUserName.addCharacterSpacing(kernValue: -0.36)
        labelUserName.textColor = .darkbluegray
        viewUserRankView.addSubview(labelUserName)
        labelUserName.snp.makeConstraints { make in
            make.leading.equalTo(labelUserLV.snp.leading)
            make.top.equalTo(labelUserLV.snp.bottom)
        }

        imageViewFlag2.image = UIImage(named: "FlagIconMainColor@3x")
        imageViewFlag2.contentMode = .scaleAspectFit
        viewUserRankView.addSubview(imageViewFlag2)
        imageViewFlag2.snp.makeConstraints { make in
            make.trailing.equalTo(viewUserRankView.snp.trailing).offset(-16.7)
            make.centerY.equalTo(labelUserName.snp.centerY).offset(-2)
            make.width.equalTo(15.3)
            make.height.equalTo(17.3)
        }

        labelUsertimes.text = "1회"
        labelUsertimes.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 20)
        labelUsertimes.textColor = .mainColor
        labelUsertimes.textAlignment = .right
        viewUserRankView.addSubview(labelUsertimes)
        labelUsertimes.snp.makeConstraints { make in
            make.trailing.equalTo(imageViewFlag2.snp.leading).offset(-6.2)
            make.centerY.equalTo(labelUserName.snp.centerY)
        }
    }
}
