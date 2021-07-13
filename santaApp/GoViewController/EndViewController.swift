//
//  EndViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/02.
//

import UIKit
import MobileCoreServices

class EndViewController : BaseViewController, UINavigationBarDelegate {
    let buttonEnd = UIButton()
    let picker = UIImagePickerController()
    var flagImageSave = false

    var imageView : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradient(color1: UIColor(hex:0x24C7B9) , color2: UIColor(hex: 0x9AC7FF))
        picker.delegate = self
        navigationBarSet()
        buttonSetEnd()
    }
    // MARK: 네비게이션 바
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .white
        return button
        
    }()
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
        let vc = BaseTabbarController()
        vc.index = 2
        self.changeRootViewController(vc)
    }
    // MARK: 도착버튼
    func buttonSetEnd() {
    buttonEnd.backgroundColor = .black
        buttonEnd.addTarget(self, action: #selector(actionEndButton), for: .touchUpInside)
        view.addSubview(buttonEnd)
        
        buttonEnd.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
    }
    @objc func actionEndButton() {
            if(UIImagePickerController .isSourceTypeAvailable(.camera)){
                picker.sourceType = .camera
                present(picker, animated: false, completion: nil)
            }
            else{
                print("Camera not available")
            }
        }
}


extension EndViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView?.image = image
        }
        
        dismiss(animated: true) {
            self.presentAlert(title: "해당 사진으로 진행할까요?", message: "해당 산과 무관한 사진을 올릴 시\n제재가 가해질 수 있습니다.", isCancelActionIncluded: true, preferredStyle: .alert) { action in
                let nextVC = ConquerViewController()
                nextVC.modalPresentationStyle = .overFullScreen
                nextVC.modalTransitionStyle = .crossDissolve
                self.present(nextVC, animated: true, completion: nil)
            }
        }
    }
}
