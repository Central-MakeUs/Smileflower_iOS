//
//  ProfileViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import UIKit

class ProfileViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSet()
    }
    //MARK: 네비게이션
    func navigationBarSet() {
        navigationItem.title = "프로필"
    }
    
}
