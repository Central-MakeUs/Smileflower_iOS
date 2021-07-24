//
//  ForgetPasswordViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/23.
//

import UIKit

class ForgetPasswordViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSet()
        setLabelSantaLogo()
        setLabelForgetPassword()
        setLabelResettingPassword()
        setTextFieldEmail()
        setButtonResettingPassword()
        self.dismissKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.textFieldEmail.becomeFirstResponder()
    }
    override func viewWillLayoutSubviews() {
        let borderID = CALayer()
        borderID.frame = CGRect(x: 0, y: textFieldEmail.frame.size.height-1, width: textFieldEmail.frame.width, height: 1)
        borderID.backgroundColor = UIColor.lightbluegray.cgColor
        textFieldEmail.layer.addSublayer(borderID)
    }
    // MARK: 네비게이션 바
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .titleColorGray
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
        dismiss(animated: true, completion: nil)
    }
    //MARk: 산타 로고
    let labelSantaLogo = UILabel()
    func setLabelSantaLogo() {
        labelSantaLogo.text = "SANTA"
        labelSantaLogo.font = UIFont(name: Constant.fontCocogoose, size: 28)
        labelSantaLogo.addCharacterSpacing(kernValue: -1.4)
        labelSantaLogo.textColor = .mainColor
        view.addSubview(labelSantaLogo)
        labelSantaLogo.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(113)
            make.leading.equalTo(view.snp.leading).offset(32)
        }
    }
    //MARK: 비밀번호 찾기
    let labelForgetPassword = UILabel()
    func setLabelForgetPassword() {
        labelForgetPassword.text = "비밀번호 찾기"
        labelForgetPassword.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 36)
        labelForgetPassword.textColor = .darkbluegray
        view.addSubview(labelForgetPassword)
        labelForgetPassword.snp.makeConstraints { make in
            make.leading.equalTo(labelSantaLogo.snp.leading)
            make.top.equalTo(labelSantaLogo.snp.bottom).offset(6)
        }
    }
    //MARK: 비밀번호 찾기 설명
    let labelResettingPassword = UILabel()
    func setLabelResettingPassword() {
        labelResettingPassword.text = "산타에 가입했던 이메일을 입력하면\n비밀번호 재설정 메일을 보내드립니다."
        labelResettingPassword.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 14)
        labelResettingPassword.textColor = .bluegray
        labelResettingPassword.numberOfLines = 2
        view.addSubview(labelResettingPassword)
        labelResettingPassword.snp.makeConstraints { make in
            make.leading.equalTo(labelSantaLogo.snp.leading)
            make.top.equalTo(labelForgetPassword.snp.bottom).offset(14)
        }
    }
    //MARK: 이메일 입력칸
    let textFieldEmail = UITextField()
    func setTextFieldEmail() {
        textFieldEmail.placeholder = "이메일을 입력해주세요."
        textFieldEmail.addTarget(self, action: #selector(actionDidChangeTextField), for: .editingChanged)
        view.addSubview(textFieldEmail)
        textFieldEmail.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(labelResettingPassword.snp.bottom).offset(55)
            make.height.equalTo(34)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
        }
    }
    @objc func actionDidChangeTextField() {
        if let text = textFieldEmail.text {
            if text.isEmpty {
                buttonResettingPassword.isUserInteractionEnabled = false
                buttonResettingPassword.backgroundColor = .titleColorGray
            }
            else {
                buttonResettingPassword.isUserInteractionEnabled = true
                buttonResettingPassword.backgroundColor = .mainColor
            }
        }
    }
    //MARK: 비밀번호 재설정
    let buttonResettingPassword = UIButton()
    func setButtonResettingPassword() {
        buttonResettingPassword.setTitle("비밀번호 재설정", for: .normal)
        buttonResettingPassword.setTitleColor(.white, for: .normal)
        buttonResettingPassword.layer.cornerRadius = 24
        buttonResettingPassword.backgroundColor = .titleColorGray
        buttonResettingPassword.isUserInteractionEnabled = false
        buttonResettingPassword.addTarget(self, action: #selector(actionForgetPassword), for: .touchUpInside)
        view.addSubview(buttonResettingPassword)
        buttonResettingPassword.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(textFieldEmail.snp.bottom).offset(71)
            make.width.equalTo(UIScreen.main.bounds.width * 0.9)
            make.height.equalTo(48)
        }
    }
    @objc func actionForgetPassword() {
        let input = ForgetPasswordInput(email: textFieldEmail.text!)
        ForgetPasswordDataManager().appemailspassword(self, input)
        self.showIndicator()
    }
}

extension ForgetPasswordViewController : UINavigationBarDelegate {
    
}

extension ForgetPasswordViewController {
    func successDataApiForgetPassword(_ message : String) {
        self.presentAlert(title: message)
        self.dismissIndicator()
    }
    func failureDataApi(_ message : String) {
        self.presentAlert(title: message)
        self.dismissIndicator()
    }
}
