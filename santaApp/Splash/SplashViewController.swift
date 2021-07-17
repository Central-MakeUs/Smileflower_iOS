//
//  SplashViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import UIKit
import SnapKit

class SplashViewController : BaseViewController {
    let labelUp = UILabel()
    let labelSanta = UILabel()
    let imageSantaLogoleft = UIImageView()
    let imageSantaLogoRight = UIImageView()
    var autoLogin : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradient(color1: UIColor(hex:0x24C7B9) , color2: UIColor(hex: 0x9AC7FF))
        viewSetLogo()
        print("안녕?")
        AutoLoginDataManager().appusersautologin(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateLogo()
    }
    // MARK: - 산타 로고
    func viewSetLogo() {
        imageSantaLogoleft.frame = CGRect(x: UIScreen.main.bounds.width/2 - 69.55, y: UIScreen.main.bounds.height/2 - 33.55, width: 139.1, height: 67.1)
        imageSantaLogoleft.image = UIImage(named: "santaleft@3x")
        view.addSubview(imageSantaLogoleft)
        
        imageSantaLogoRight.image = UIImage(named: "santaright@3x")
        imageSantaLogoRight.frame = CGRect(x: UIScreen.main.bounds.width/2 + 29.75, y: UIScreen.main.bounds.height/2 - 33.55, width: 51.3, height: 66.6)
        view.addSubview(imageSantaLogoRight)

        
        labelSanta.text = "SANTA"
        labelSanta.textColor = .white
        labelSanta.font = UIFont(name: Constant.fontCocogoose, size: 36)
        labelSanta.alpha = 0
        labelSanta.addCharacterSpacing()
        labelSanta.textAlignment = .center
        view.addSubview(labelSanta)
        labelSanta.snp.makeConstraints { make in
        make.centerX.equalTo(view.snp.centerX)
        make.bottom.equalTo(imageSantaLogoleft.snp.top).offset(-9)
    
        labelUp.text = "우리 같이"
        labelUp.textColor = .white
            labelUp.alpha = 0
        labelUp.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 19)
        labelUp.textAlignment = .center
        view.addSubview(labelUp)
        labelUp.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(labelSanta.snp.top).offset(1.65)

            
        }
    }
        
    }
    // MARK: animate
    func animateLogo() {
        UIView.animate(withDuration: 1.0    ) {
            self.labelUp.alpha = 1
            self.labelSanta.alpha = 1
            self.imageSantaLogoRight.frame = CGRect(x: UIScreen.main.bounds.width/2 + 33.95, y: UIScreen.main.bounds.height/2 - 27.75, width: 51.3, height: 66.6)
        } completion: { finished in
            sleep(1/10*7)
            let nextVC = LoginViewController()
            nextVC.boolautoLogin = self.autoLogin
            self.changeRootViewController(nextVC)
        }

    }
}
