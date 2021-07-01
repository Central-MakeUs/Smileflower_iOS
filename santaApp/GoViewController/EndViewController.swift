//
//  EndViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/02.
//

import UIKit
import MobileCoreServices

class EndViewController : BaseViewController {
    let buttonEnd = UIButton()
    let picker = UIImagePickerController()
    var flagImageSave = false

    var imageView : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        picker.delegate = self
        buttonSetEnd()
    }
    
    // MARK : 도착버튼
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
        
        dismiss(animated: true, completion: nil)
    }
}
