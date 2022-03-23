//
//  SignInViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/15.
//

import UIKit

class SignInViewController : BaseViewController{
    
    override func viewDidLoad() {
        TrackingTool.Screen(screenName: "view_email_login")
        
        super.viewDidLoad()
        self.dismissKeyboardWhenTappedAround()
        navigationBarSet()
        setLabelSantaLogo()
        setLabelSignIn()
        setTextFieldID()
        setTextFieldPassword()
        setButtonSignIn()
        setButtonForgetPassword()
        setButtonSignUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.textFieldID.becomeFirstResponder()
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
        TrackingTool.Action(actionName: "action_back_email_login", param: ["backEmailLogin":""])
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
    let viewBorderID : UIView = {
        let view = UIView()
        view.backgroundColor = .lightbluegray
        return view
    }()
    func setTextFieldID() {
        textFieldID.placeholder = "이메일"
        textFieldID.borderStyle = .none
        textFieldID.addTarget(self, action: #selector(actionDidEditID), for: .editingChanged)
        view.addSubview(textFieldID)
        textFieldID.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(labelSignIn.snp.bottom).offset(34)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(34)
        }
            
        view.addSubview(viewBorderID)
        viewBorderID.snp.makeConstraints { make in
            make.top.equalTo(textFieldID.snp.bottom)
            make.leading.trailing.equalTo(textFieldID)
            make.height.equalTo(1)
        }
    }
    @objc func actionDidEditID() {
        guard let text = textFieldID.text else {
            return
        }
        
        if text.count == 0 {
            viewBorderID.backgroundColor = .lightbluegray
        } else {
            viewBorderID.backgroundColor = .mainColor
        }
    }
    //MARK: 비밀번호 입력칸
    let textFieldPassword = UITextField()
    let viewBorderPassword : UIView = {
        let view = UIView()
        view.backgroundColor = .lightbluegray
        return view
    }()
    func setTextFieldPassword() {
        textFieldPassword.placeholder = "비밀번호"
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.addTarget(self, action: #selector(actionDidEditPassword), for: .editingChanged)
        view.addSubview(textFieldPassword)
        textFieldPassword.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(textFieldID.snp.bottom).offset(28)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(34)
        }
        
        view.addSubview(viewBorderPassword)
        viewBorderPassword.snp.makeConstraints { make in
            make.trailing.leading.equalTo(textFieldPassword)
            make.top.equalTo(textFieldPassword.snp.bottom)
            make.height.equalTo(1)
        }
    }
    @objc func actionDidEditPassword() {
        guard let text = textFieldPassword.text else {
            return
        }
        
        if text.count == 0 {
            viewBorderPassword.backgroundColor = .lightbluegray
        } else {
            viewBorderID.backgroundColor = .mainColor
        }
    }
    //MARK: 비밀번호를 잊으셨습니까? 버튼
    let buttonForgetPassword = UIButton()
    func setButtonForgetPassword() {
        buttonForgetPassword.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        buttonForgetPassword.setTitleColor(.lightbluegray, for: .normal)
        buttonForgetPassword.addTarget(self, action: #selector(actionGoForgetPasswordView), for: .touchUpInside)
        buttonForgetPassword.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 12)
        view.addSubview(buttonForgetPassword)
        buttonForgetPassword.snp.makeConstraints { make in
            make.top.equalTo(textFieldPassword.snp.bottom).offset(17)
            make.trailing.equalTo(textFieldPassword.snp.trailing)
        }
    }
    @objc func actionGoForgetPasswordView() {
        TrackingTool.Action(actionName: "action_go_forget_password", param: ["goForgetPassword":""])
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
        TrackingTool.Action(actionName: "action_do_email_login", param: ["doEmailLogin":""])
        let FCMTK = UserDefaults.standard.value(forKey: "FCM_TOKEN") as? String ?? ""
        let input = SignInViewControllerInput(emailId: textFieldID.text ?? "", password: textFieldPassword.text ?? "", pushToken: FCMTK, tokenType: "i")
        print(FCMTK)
        SignInViewControllerDataManager().appuserslogin(self, input)
    }
    
    let buttonSignUp : UIButton = {
        let button = UIButton()
        button.layer.zPosition = 400
        return button
    }()
    let labelSignUp : UILabel = {
        let label = UILabel()
        let string = "계정이 없으신가요? 가입하기"
        label.textColor = .bluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 12)
        let fontSize = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 12)
        let attributeStr = NSMutableAttributedString(string: string)
        attributeStr.addAttribute(.font, value: fontSize, range: NSRange.init(location: 0, length: 10))
        label.attributedText = attributeStr
        return label
    }()
    
    func setButtonSignUp() {
        buttonSignUp.addTarget(self, action: #selector(actionGoSignUp), for: .touchUpInside)
        view.addSubview(buttonSignUp)
        buttonSignUp.snp.makeConstraints { make in
            make.centerX.equalTo(buttonSignIn)
            make.top.equalTo(buttonSignIn.snp.bottom).offset(12)
        }
        view.addSubview(labelSignUp)
        labelSignUp.snp.makeConstraints { make in
            make.edges.equalTo(buttonSignUp)
        }
    }
    @objc func actionGoSignUp() {
        let nextVC = SignUpViewController()
        present(nextVC, animated: true, completion: nil)
    }
}
extension SignInViewController {
    func successLoginData(_ result : SignInViewControllerResult) {
        Constant.JWTToken = result.jwt
        UserDefaults.standard.set(result.jwt, forKey: "JWTToken")
        Constant.userIdx = result.userIdx
        Constant.userEmail = textFieldID.text!
        UserDefaults.standard.set(Constant.userEmail, forKey: "loginMethod")//최신버전 저장
        self.changeRootViewController(BaseTabbarController())
    }
    func successDataButError(_ result : SignInViewControllerEntity) {
        self.presentAlert(title: result.message)
    }
    func failureDataApi() {
        self.presentAlert(title: "네트워크 장애")
    }
}
