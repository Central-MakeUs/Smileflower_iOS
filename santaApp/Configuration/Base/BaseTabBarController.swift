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
    
    let homeTabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "homeButton@3x"), tag: 0)
    let searchTabBarItem = UITabBarItem(title: "찜한산", image: UIImage(named: "likeButton@3x"), tag: 1)
    let selectTabBarItem = UITabBarItem(title: .none, image: .none, tag: 2)
    let reciptTabBarItem = UITabBarItem(title: "프로필", image: UIImage(named: "person@3x"), tag: 3)
    let myBaeMinTabBarItem = UITabBarItem(title: "설정", image: UIImage(named: "setting@3x"), tag: 4)
    
    
    func setupMiddleButton() {
           let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 82, height: 82))
           var menuButtonFrame = menuButton.frame
           menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 50
           menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
           menuButton.frame = menuButtonFrame

           menuButton.backgroundColor = UIColor.mainColor
           menuButton.layer.cornerRadius = menuButtonFrame.height/2
        menuButton.layer.shadowColor = UIColor.mainColor.cgColor
        menuButton.layer.shadowOpacity = 1.0
        menuButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        menuButton.layer.shadowRadius = 3
           view.addSubview(menuButton)

           menuButton.setImage(UIImage(named: "FlagIcon@3x"), for: .normal)
           menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

           view.layoutIfNeeded()
       }
    
    @objc private func menuButtonAction(sender: UIButton) {
            selectedIndex = 2
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
    }
}
