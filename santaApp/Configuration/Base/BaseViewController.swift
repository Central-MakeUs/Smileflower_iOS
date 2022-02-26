//
//  BaseViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import UIKit
class BaseViewController : UIViewController, UINavigationBarDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
        navigationController?.navigationBar.isHidden = true
    }
}
