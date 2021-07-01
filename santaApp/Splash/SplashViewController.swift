//
//  SplashViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import UIKit
import SnapKit

class SplashViewController : BaseViewController {
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabel()
        goNextView()
    }
    
    func setLabel() {
        self.view.addSubview(label)
        
        label.text = "시작화면입니다."
        label.textColor = .black
        
        self.label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func goNextView() {
        sleep(2)
        self.changeRootViewController(BaseTabbarController())
    }
}
