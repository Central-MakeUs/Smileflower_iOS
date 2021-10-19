//
//  SignInViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

import UIKit

class SignInViewController : BaseViewController, UINavigationBarDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTappedAround()
        navigationBarSet()
        setLabelSantaLogo()
        setLabelSignIn()
        setTextFieldID()
        setTextFieldPassword()
        setButtonSignIn()
        setButtonForgetPassword()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.textFieldID.becomeFirstResponder()
    }
    override func viewDidLayoutSubviews() {
        let borderID = CALayer()
        borderID.frame = CGRect(x: 0, y: textFieldID.frame.size.height-1, width: textFieldID.frame.width, height: 1)
        borderID.backgroundColor = UIColor.lightbluegray.cgColor
        textFieldID.layer.addSublayer(borderID)
        
        let borderPassword = CALayer()
        borderPassword.frame = CGRect(x: 0, y: textFieldID.frame.size.height-1, width: textFieldID.frame.width, height: 1)
        borderPassword.backgroundColor = UIColor.lightbluegray.cgColor
        textFieldPassword.layer.addSublayer(borderPassword)
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
    //MARK: 로그인하기
    let labelSignIn = UILabel()
    func setLabelSignIn() {
        labelSignIn.text = "로그인하기"
        labelSignIn.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 36)
        labelSignIn.textColor = .darkbluegray
        view.addSubview(labelSignIn)
        labelSignIn.snp.makeConstraints { make in
            make.leading.equalTo(labelSantaLogo.snp.leading)
            make.top.equalTo(labelSantaLogo.snp.bottom).offset(6)
        }
    }
    //MARK: 아이디입력칸
    let textFieldID = UITextField()
    func setTextFieldID() {
        textFieldID.placeholder = "이메일"
        textFieldID.borderStyle = .none
        view.addSubview(textFieldID)
        textFieldID.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(labelSignIn.snp.bottom).offset(34)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(34)
        }
    }
    //MARK: 비밀번호 입력칸
    let textFieldPassword = UITextField()
    func setTextFieldPassword() {
        textFieldPassword.placeholder = "비밀번호"
        textFieldPassword.isSecureTextEntry = true
        view.addSubview(textFieldPassword)
        textFieldPassword.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(textFieldID.snp.bottom).offset(28)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(34)
        }
    }
    //MARK: 비밀번호를 잊으셨습니까? 버튼
    let buttonForgetPassword = UIButton()
    func setButtonForgetPassword() {
        buttonForgetPassword.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        buttonForgetPassword.setTitleColor(.mainColor, for: .normal)
        buttonForgetPassword.addTarget(self, action: #selector(actionGoForgetPasswordView), for: .touchUpInside)
        buttonForgetPassword.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 12)
        view.addSubview(buttonForgetPassword)
        buttonForgetPassword.snp.makeConstraints { make in
            make.top.equalTo(textFieldPassword.snp.bottom).offset(17)
            make.trailing.equalTo(textFieldPassword.snp.trailing)
        }
    }
    @objc func actionGoForgetPasswordView() {
        let nextVC = ForgetPasswordViewController()
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
    //MARK: 로그인 버튼
    let buttonSignIn = UIButton()
    func setButtonSignIn() {
        buttonSignIn.setTitle("시작하기", for: .normal)
        buttonSignIn.setTitleColor(.white, for: .normal)
        buttonSignIn.layer.cornerRadius = 24
        buttonSignIn.backgroundColor = .mainColor
        buttonSignIn.addTarget(self, action: #selector(actionSignIn), for: .touchUpInside)
        view.addSubview(buttonSignIn)
        buttonSignIn.snp.makeConstraints { make in
            make.top.equalTo(textFieldPassword.snp.bottom).offset(69)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(48)
        }
    }
    @objc func actionSignIn() {
        let input = SignInViewControllerInput(emailId: textFieldID.text ?? "", password: textFieldPassword.text ?? "")
        SignInViewControllerDataManager().appuserslogin(self, input)
    }
}
extension SignInViewController {
    func successLoginData(_ result : SignInViewControllerResult) {
        Constant.JWTToken = result.jwt
        UserDefaults.standard.set(result.jwt, forKey: "JWTToken")
        Constant.userIdx = result.userIdx
        Constant.userEmail = textFieldID.text!
        self.changeRootViewController(BaseTabbarController())
    }
    func successDataButError(_ result : SignInViewControllerEntity) {
        self.presentAlert(title: result.message)
    }
    func failureDataApi() {
        self.presentAlert(title: "네트워크 장애")
    }
}
