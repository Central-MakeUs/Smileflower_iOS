//
//  BaseTabBarController.swift
//  SnapKitTest
//
//  Created by 노영재 on 2021/05/15.
//

import UIKit

class BaseTabbarController : UITabBarController, UITabBarControllerDelegate {
    let homeViewController = HomeViewController()
    let searchViewController = PickMountainViewController()
    let selectViewController = GoViewController()
    let reciptViewController = ProfileViewController()
    let myBaeMinViewController = SetupViewController()
    
    let homeTabBarItem = UITabBarItem(title: .none  , image: .none, tag: 0)
    let searchTabBarItem = UITabBarItem(title: .none, image: .none, tag: 1)
    let selectTabBarItem = UITabBarItem(title: .none, image: .none, tag: 2)
    let reciptTabBarItem = UITabBarItem(title: .none, image: .none, tag: 3)
    let myBaeMinTabBarItem = UITabBarItem(title: .none, image: .none, tag: 4)
    // MARK: 왼쪽 버턴
    func setUphomeButton() {
        let homeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 47, height: 47))
        var homeButtonFrame = homeButton.frame
        homeButtonFrame.origin.y = view.bounds.height - homeButtonFrame.height - 40
        homeButtonFrame.origin.x = 21
        homeButton.frame = homeButtonFrame
        homeButton.backgroundColor = .mainColor
        homeButton.semanticContentAttribute = .forceLeftToRight
        
        view.addSubview(homeButton)
        homeButton.addTarget(self, action: #selector(homeButtonAction(sender:)), for: .touchUpInside)
        view.layoutIfNeeded()
    }
    @objc private func homeButtonAction(sender: UIButton) {
            selectedIndex = 0
        }
    // MARK: 찜한산 버튼
    func setUplikeButton() {
        let likeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 47, height: 47))
        var likeButtonFrame = likeButton.frame
        likeButtonFrame.origin.y = view.bounds.height - likeButtonFrame.height - 40
        likeButtonFrame.origin.x = 85
        likeButton.frame = likeButtonFrame
        likeButton.backgroundColor = .mainColor
        likeButton.semanticContentAttribute = .forceLeftToRight
        view.addSubview(likeButton)
        likeButton.addTarget(self, action: #selector(likeButtonAction(sender:)), for: .touchUpInside)
        view.layoutIfNeeded()
    }
    @objc private func likeButtonAction(sender: UIButton) {
            selectedIndex = 1
        }
    // MARK: 가운데 버튼
    func setupMiddleButton() {
           let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 82, height: 82))
           var menuButtonFrame = menuButton.frame
           menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 50
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
        menuButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2.15, bottom: 0, right: 0)
           menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

           view.layoutIfNeeded()
       }
    
    @objc private func menuButtonAction(sender: UIButton) {
            selectedIndex = 2
        }
    // MARK : 프로필 버튼
    func setUpPorfileButton() {
        let profileButton = UIButton(frame: CGRect(x: 0, y: 0, width: 47, height: 47))
        var profileButtonFrame = profileButton.frame
        profileButtonFrame.origin.y = view.bounds.height - profileButtonFrame.height - 40
        profileButtonFrame.origin.x = 242
        profileButton.frame = profileButtonFrame
        profileButton.backgroundColor = .mainColor
        profileButton.semanticContentAttribute = .forceLeftToRight
        view.addSubview(profileButton)
        profileButton.addTarget(self, action: #selector(profileButtonAction(sender:)), for: .touchUpInside)
        view.layoutIfNeeded()
    }
    @objc private func profileButtonAction(sender: UIButton) {
            selectedIndex = 3
        }
    // MARK : 설정 버튼
    func setUpSettingButton() {
        let settingButton = UIButton(frame: CGRect(x: 0, y: 0, width: 47, height: 47))
        var settingButtonFrame = settingButton.frame
        settingButtonFrame.origin.y = view.bounds.height - settingButtonFrame.height - 40
        settingButtonFrame.origin.x = 306
        settingButton.frame = settingButtonFrame
        settingButton.backgroundColor = .mainColor
        settingButton.semanticContentAttribute = .forceLeftToRight
        view.addSubview(settingButton)
        settingButton.addTarget(self, action: #selector(settingButtonAction(sender:)), for: .touchUpInside)
        view.layoutIfNeeded()
    }
    @objc private func settingButtonAction(sender: UIButton) {
            selectedIndex = 4
        }
    
    
    override func viewDidLoad() {
        SetUpTabbarView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.frame.size.height = 106
        tabBar.frame.origin.y = view.frame.height - 106
    }
    func SetUpTabbarView() {
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        let selectNavigationController = UINavigationController(rootViewController: selectViewController)
        let reciptNavigationController = UINavigationController(rootViewController: reciptViewController)
        let myBaeMinNavigationController = UINavigationController(rootViewController: myBaeMinViewController)
        
        homeNavigationController.tabBarItem = homeTabBarItem
        searchNavigationController.tabBarItem = searchTabBarItem
        selectNavigationController.tabBarItem = selectTabBarItem
        reciptNavigationController.tabBarItem = reciptTabBarItem
        myBaeMinNavigationController.tabBarItem = myBaeMinTabBarItem
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
        setUphomeButton()
        setUplikeButton()
        setUpPorfileButton()
        setUpSettingButton()
    }
}
