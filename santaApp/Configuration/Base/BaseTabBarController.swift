//
//  BaseTabBarController.swift
//  SnapKitTest
//
//  Created by 노영재 on 2021/05/15.
//

import UIKit

class BaseTabbarController : UITabBarController, UITabBarControllerDelegate {
    let homeViewController = HomeViewController()
    let flagViewController = FlagMapViewController()
    let goViewController = GoViewController()
    let likeViewController = PickMountainViewController()
    let profileViewController = ProfileViewController()
    
    let homeTabBarItem = UITabBarItem(title: "홈"  , image: UIImage(named: "homeButton@3x"), tag: 0)
    let flagTabBarItem = UITabBarItem(title: "정복한 산", image: UIImage(named: "icTabMountainGray"), tag: 1)
    let goTabBarItem = UITabBarItem(title: .none, image: .none, tag: 2)
    let likeTabBarItem = UITabBarItem(title: "찜한 산", image: UIImage(named: "likeButton@3x"), tag: 3)
    let profileTabBarItem = UITabBarItem(title: "프로필", image: UIImage(named: "person@3x"), tag: 4)
    let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 82, height: 82))

    var index : Int = 0
    // MARK: 가운데 버튼
    func setupMiddleButton() {
           var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - view.bounds.height/16.3
           menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
           menuButton.frame = menuButtonFrame

           menuButton.backgroundColor = UIColor.mainColor
           menuButton.layer.cornerRadius = menuButtonFrame.height/2
        menuButton.layer.shadowColor = UIColor.mainColor.cgColor
        menuButton.layer.shadowOpacity = 0.3
        menuButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        menuButton.layer.shadowRadius = 18
           view.addSubview(menuButton)

           menuButton.setImage(UIImage(named: "FlagIcon@3x"), for: .normal)
        menuButton.imageEdgeInsets = UIEdgeInsets(top: 1.6, left: 2.15, bottom: -1.6, right: -2.15)
           menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

           view.layoutIfNeeded()
       }
    
    @objc private func menuButtonAction(sender: UIButton) {
        TrackingTool.Action(actionName: "action_go_conquer_mountain", param: ["": ""])
            selectedIndex = 2
        }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(buttonHidden), name: Notification.Name("middleButtonHidden"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(buttonApper), name: Notification.Name("middleButtonAppear"), object: nil)
    }
    
    @objc func buttonHidden() {
        menuButton.isHidden = true
    }
    @objc func buttonApper() {
        menuButton.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SetUpTabbarView()
        self.selectedIndex = index
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.frame.size.height = UIScreen.main.bounds.height/7.6
        tabBar.frame.origin.y = view.frame.height - UIScreen.main.bounds.height/7.6
    }
    func SetUpTabbarView() {
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let flagNavigationController = UINavigationController(rootViewController: flagViewController)
        let goNavigationController = UINavigationController(rootViewController: goViewController)
        let likeNavigationController = UINavigationController(rootViewController: likeViewController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
                
        homeTabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        homeTabBarItem.titlePositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
        flagTabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        flagTabBarItem.titlePositionAdjustment = UIOffset(horizontal: -5, vertical: 0)
        likeTabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        likeTabBarItem.titlePositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
        profileTabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        profileTabBarItem.titlePositionAdjustment = UIOffset(horizontal: -5, vertical: 0)
        
        homeNavigationController.tabBarItem = homeTabBarItem
        flagNavigationController.tabBarItem = flagTabBarItem
        goNavigationController.tabBarItem = goTabBarItem
        likeNavigationController.tabBarItem = likeTabBarItem
        profileNavigationController.tabBarItem = profileTabBarItem
        self.viewControllers = [homeNavigationController, flagNavigationController, goNavigationController, likeNavigationController, profileNavigationController]
        self.tabBar.barTintColor = .white
        
        self.tabBar.tintColor = .mainColor
        self.tabBar.unselectedItemTintColor = .titleColorGray
        self.delegate = self
        UITabBar.clearShadow()
        self.tabBar.layer.applyShadow(color: .titleColorGray, alpha: 0.3, x: 0, y: 0, blur: 12)
        self.tabBar.layer.cornerRadius = 35
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        setupMiddleButton()
    }
}
