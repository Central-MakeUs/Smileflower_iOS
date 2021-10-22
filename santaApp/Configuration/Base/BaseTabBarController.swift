//
//  BaseTabBarController.swift
//  SnapKitTest
//
//  Created by 노영재 on 2021/05/15.
//

import UIKit

class BaseTabbarController : UITabBarController, UITabBarControllerDelegate {
    let homeViewController = HomeViewController()
    let likeViewController = PickMountainViewController()
    let selectViewController = GoViewController()
    let profileViewController = ProfileViewController()
    let settingController = SetupViewController()
    
    let homeTabBarItem = UITabBarItem(title: "홈"  , image: UIImage(named: "homeButton@3x"), tag: 0)
    let likeTabBarItem = UITabBarItem(title: "찜한 산", image: UIImage(named: "likeButton@3x"), tag: 1)
    let selectTabBarItem = UITabBarItem(title: .none, image: .none, tag: 2)
    let profileTabBarItem = UITabBarItem(title: "프로필", image: UIImage(named: "person@3x"), tag: 3)
    let settingTabBarItem = UITabBarItem(title: "설정", image: UIImage(named: "setting@3x"), tag: 4)

    var index : Int = 0
    // MARK: 가운데 버튼
    func setupMiddleButton() {
           let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 82, height: 82))
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
        SetUpTabbarView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.selectedIndex = index
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.frame.size.height = UIScreen.main.bounds.height/7.6
        tabBar.frame.origin.y = view.frame.height - UIScreen.main.bounds.height/7.6
    }
    func SetUpTabbarView() {
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let searchNavigationController = UINavigationController(rootViewController: likeViewController)
        let selectNavigationController = UINavigationController(rootViewController: selectViewController)
        let reciptNavigationController = UINavigationController(rootViewController: profileViewController)
        let myBaeMinNavigationController = UINavigationController(rootViewController: settingController)
                
        homeTabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        homeTabBarItem.titlePositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
        likeTabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        likeTabBarItem.titlePositionAdjustment = UIOffset(horizontal: -5, vertical: 0)
        profileTabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        profileTabBarItem.titlePositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
        settingTabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        settingTabBarItem.titlePositionAdjustment = UIOffset(horizontal: -5, vertical: 0)
        
        homeNavigationController.tabBarItem = homeTabBarItem
        searchNavigationController.tabBarItem = likeTabBarItem
        selectNavigationController.tabBarItem = selectTabBarItem
        reciptNavigationController.tabBarItem = profileTabBarItem
        myBaeMinNavigationController.tabBarItem = settingTabBarItem
        self.viewControllers = [homeNavigationController, searchNavigationController, selectNavigationController, reciptNavigationController, myBaeMinNavigationController]
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
