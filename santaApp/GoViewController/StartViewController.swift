//
//  StartViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/02.
//

import UIKit

class StartViewController : BaseViewController,UINavigationBarDelegate {

    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .titleColorGray
        return button
        
    }()
    
    var mountainIdx : Int?
    let labelMountainName = UILabel()
    let imageViewPosition = UIImageView()
    let labelStartandRun = UILabel()
    let buttonStart = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSet()
        labelSetMountainName()
        imageViewSetPosition()
        labelSetStartAndRun()
        buttonSetStart()
    }
    // MARK: 네비게이션 바
    func navigationBarSet() {
        let height: CGFloat = 75
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.white
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
        let vc = BaseTabbarController()
        vc.index = 2
        self.changeRootViewController(vc)
    }
    // MARK: 산 이름
    func labelSetMountainName() {
        labelMountainName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 64)
        labelMountainName.setTextWithLineHeight(text: labelMountainName.text, lineHeight: 77)
        labelMountainName.textAlignment = .center
        view.addSubview(labelMountainName)
        labelMountainName.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX).offset(22.2)
            make.top.equalTo(view.snp.top).offset(153.6)
        }
    }
    // MARK: 산 이름 옆에 이미지
    func imageViewSetPosition() {
        imageViewPosition.image = UIImage(named: "position@3x")
        imageViewPosition.contentMode = .scaleAspectFill
        view.addSubview(imageViewPosition)
        imageViewPosition.snp.makeConstraints { make in
            make.trailing.equalTo(labelMountainName.snp.leading).offset(-10.2)
            make.centerY.equalTo(labelMountainName.snp.centerY).offset(-5)
            make.width.equalTo(45.3)
            make.height.equalTo(53.8)
        }
    }
    // MARK: 출발 버튼과 함께 달려주세요!
    func labelSetStartAndRun() {
        labelStartandRun.text = " 출발 버튼과 함께 달려주세요!"
        labelStartandRun.textAlignment = .center
        labelStartandRun.setTextWithLineHeight(text: labelStartandRun.text, lineHeight: 20)
        labelStartandRun.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 17)
        
        view.addSubview(labelStartandRun)
        labelStartandRun.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(234)
        }
    }
    // MARK: 출발 버튼
    func buttonSetStart() {
        buttonStart.setImage(UIImage(named: "startButton@3x"), for: .normal)
        buttonStart.addTarget(self, action: #selector(actionStartButton), for: .touchUpInside)
        buttonStart.isSelected = false
        view.addSubview(buttonStart)
        
        buttonStart.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(labelStartandRun.snp.bottom).offset(46)
            make.width.equalTo(296)
            make.height.equalTo(296)
        }
    }
    @objc func actionStartButton() {
        let nextVC = EndViewController()
        if let idx = mountainIdx {
            nextVC.mountainIdx = idx
        }
        nextVC.labelMountain.text = labelMountainName.text
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
}
