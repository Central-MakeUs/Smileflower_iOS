//
//  SignUpViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/14.
//

import UIKit
class SignUpViewController : BaseViewController, UINavigationBarDelegate {
    var boolOverlap : Bool = false
    var boolisitImail : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTappedAround()
        navigationBarSet()
        setLabelSantaLogo()
        setLabelSignUp()
        setTextFieldID()
        setTextFieldPassword()
        setTextFieldPasswordConfirm()
        setTextFieldNicname()
        setButtonNicnameOverlap()
        setButtonSignUp()
        setLabelContract()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.textFieldID.becomeFirstResponder()
    }
    override func viewWillLayoutSubviews() {
        let borderID = CALayer()
        borderID.frame = CGRect(x: 0, y: textFieldID.frame.size.height-1, width: textFieldID.frame.width, height: 1)
        borderID.backgroundColor = UIColor.lightbluegray.cgColor
        textFieldID.layer.addSublayer(borderID)
        
        let borderPassword = CALayer()
        borderPassword.frame = CGRect(x: 0, y: textFieldID.frame.size.height-1, width: textFieldID.frame.width, height: 1)
        borderPassword.backgroundColor = UIColor.lightbluegray.cgColor
        textFieldPassword.layer.addSublayer(borderPassword)
        
        let borderPasswordComfirm = CALayer()
        borderPasswordComfirm.frame = CGRect(x: 0, y: textFieldID.frame.size.height-1, width: textFieldID.frame.width, height: 1)
        borderPasswordComfirm.backgroundColor = UIColor.lightbluegray.cgColor
        textFieldPasswordConfirm.layer.addSublayer(borderPasswordComfirm)
        
        let borderNicname = CALayer()
        borderNicname.frame = CGRect(x: 0, y: textFieldID.frame.size.height-1, width: textFieldID.frame.width, height: 1)
        borderNicname.backgroundColor = UIColor.lightbluegray.cgColor
        textFieldNicname.layer.addSublayer(borderNicname)
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
    //MARK: 회원가입하기
    let labelSignUp = UILabel()
    func setLabelSignUp() {
        labelSignUp.text = "회원가입하기"
        labelSignUp.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 36)
        labelSignUp.textColor = .darkbluegray
        view.addSubview(labelSignUp)
        labelSignUp.snp.makeConstraints { make in
            make.leading.equalTo(labelSantaLogo.snp.leading)
            make.top.equalTo(labelSantaLogo.snp.bottom).offset(6)
        }
    }
    //MARK: 아이디입력칸
    let textFieldID = UITextField()
    let textFieldIDExplain = UILabel()
    func setTextFieldID() {
        textFieldID.placeholder = "이메일"
        textFieldID.borderStyle = .none
        view.addSubview(textFieldID)
        textFieldID.addTarget(self, action: #selector(actiondidChange), for: .editingChanged)
        textFieldID.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(labelSignUp.snp.bottom).offset(34)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(34)
        }
        textFieldIDExplain.text = ""
        textFieldIDExplain.textColor = .mainColor
        view.addSubview(textFieldIDExplain)
        textFieldIDExplain.snp.makeConstraints { make in
            make.leading.equalTo(textFieldID.snp.leading)
            make.top.equalTo(textFieldID.snp.bottom).offset(7)
        }
    }
    @objc func actiondidChange() {
        if textFieldID.text?.isEmpty == false,
           textFieldPassword.text?.isEmpty == false,
           textFieldPasswordConfirm.text?.isEmpty == false,
           textFieldNicname.text?.isEmpty == false,
           boolOverlap == true {
            buttonSignUp.isUserInteractionEnabled = true
            buttonSignUp.backgroundColor = .mainColor
        }
        else {
            buttonSignUp.isUserInteractionEnabled = false
            buttonSignUp.backgroundColor = .titleColorGray
        }
    }
    //MARK: 비밀번호 입력칸
    let labelPasswordExplain = UILabel()
    let textFieldPassword = UITextField()
    func setTextFieldPassword() {
        textFieldPassword.placeholder = "비밀번호"
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.addTarget(self, action: #selector(actiondidChangeShowLabel), for: .editingChanged)
        view.addSubview(textFieldPassword)
        textFieldPassword.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(textFieldID.snp.bottom).offset(28)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(34)
        }
        labelPasswordExplain.text = "8~16자로 입력해주세요."
        labelPasswordExplain.textColor = .mainColor
        labelPasswordExplain.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 11)
        view.addSubview(labelPasswordExplain)
        labelPasswordExplain.snp.makeConstraints { make in
            make.leading.equalTo(textFieldPassword.snp.leading)
            make.top.equalTo(textFieldPassword.snp.bottom).offset(9)
        }
    }
    @objc func actiondidChangeShowLabel() {
        
        if textFieldID.text?.isEmpty == false,
           textFieldPassword.text?.isEmpty == false,
           textFieldPasswordConfirm.text?.isEmpty == false,
           textFieldNicname.text?.isEmpty == false,
           boolOverlap == true {
            buttonSignUp.isUserInteractionEnabled = true
            buttonSignUp.backgroundColor = .mainColor
        }
        else {
            buttonSignUp.isUserInteractionEnabled = false
            buttonSignUp.backgroundColor = .titleColorGray
        }
        if let textfield = textFieldPassword.text {
            if textfield.count >= 8,textfield.count <= 16
            {
                labelPasswordExplain.text = ""
            }
            else {
                labelPasswordExplain.text = "8~16자로 입력해주세요."
            }
        }
    }
    //MARK: 비밀번호 확인 입력칸
    let textFieldPasswordConfirm = UITextField()
    let labelPasswordConfirm = UILabel()
    func setTextFieldPasswordConfirm() {
        textFieldPasswordConfirm.placeholder = "비밀번호 확인"
        textFieldPasswordConfirm.isSecureTextEntry = true
        textFieldPasswordConfirm.addTarget(self, action: #selector(actiondidConfirmShowLabel), for: .editingChanged)
        view.addSubview(textFieldPasswordConfirm)
        textFieldPasswordConfirm.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(textFieldPassword.snp.bottom).offset(27)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(34)
        }
        labelPasswordConfirm.text = ""
        labelPasswordConfirm.textColor = .mainColor
        labelPasswordConfirm.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 11)
        view.addSubview(labelPasswordConfirm)
        labelPasswordConfirm.snp.makeConstraints { make in
            make.leading.equalTo(textFieldPasswordConfirm.snp.leading)
            make.top.equalTo(textFieldPasswordConfirm.snp.bottom).offset(9)
        }
    }
    @objc func actiondidConfirmShowLabel() {
        
        if textFieldID.text?.isEmpty == false,
           textFieldPassword.text?.isEmpty == false,
           textFieldPasswordConfirm.text?.isEmpty == false,
           textFieldNicname.text?.isEmpty == false,
           boolOverlap == true {
            buttonSignUp.isUserInteractionEnabled = true
            buttonSignUp.backgroundColor = .mainColor
        }
        else {
            buttonSignUp.isUserInteractionEnabled = false
            buttonSignUp.backgroundColor = .titleColorGray
        }
        if let textfield = textFieldPasswordConfirm.text, let textfieldConfirm = textFieldPassword.text {
            if textfield == textfieldConfirm {
                labelPasswordConfirm.text = "비밀번호가 일치합니다."
            }
            else {
                labelPasswordConfirm.text = "비밀번호가 일치하지 않습니다."
            }
        }
    }
    //MARK: 닉네임 입력칸
    let textFieldNicname = UITextField()
    func setTextFieldNicname() {
        textFieldNicname.placeholder = "닉네임(중복 불가)"
        textFieldNicname.addTarget(self, action: #selector(actiondidChangeNicname), for: .editingChanged)
        view.addSubview(textFieldNicname)
        textFieldNicname.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(textFieldPasswordConfirm.snp.bottom).offset(28)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(34)
        }
    }
    @objc func actiondidChangeNicname() {
        boolOverlap = false
        buttonSignUp.isUserInteractionEnabled = false
        buttonSignUp.backgroundColor = .titleColorGray
        }
    //MARK: 닉네임 중복 확인
    let buttonNicnameOverlap = UIButton()
    func setButtonNicnameOverlap() {
        buttonNicnameOverlap.setTitle("중복확인", for: .normal)
        buttonNicnameOverlap.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
        buttonNicnameOverlap.setTitleColor(.mainColor, for: .normal)
        buttonNicnameOverlap.layer.cornerRadius = 13
        buttonNicnameOverlap.layer.borderWidth = 1
        buttonNicnameOverlap.layer.borderColor = UIColor.mainColor.cgColor
        view.addSubview(buttonNicnameOverlap)
        buttonNicnameOverlap.snp.makeConstraints { make in
            make.centerY.equalTo(textFieldNicname.snp.centerY)
            make.trailing.equalTo(textFieldNicname.snp.trailing)
            make.height.equalTo(26)
            make.width.equalTo(72)
        }
        buttonNicnameOverlap.addTarget(self, action: #selector(actionCheckNicname), for: .touchUpInside)
    }
    @objc func actionCheckNicname() {
        if let text = textFieldNicname.text {
            let input = CheckNicnameInput(name: text)
            CheckNicnameDataManager().appUsersNameCheck(self, input)
        }
        if textFieldID.text?.isEmpty == false,
           textFieldPassword.text?.isEmpty == false,
           textFieldPasswordConfirm.text?.isEmpty == false,
           textFieldNicname.text?.isEmpty == false,
           boolOverlap == true {
            buttonSignUp.isUserInteractionEnabled = true
            buttonSignUp.backgroundColor = .mainColor
        }
        else {
            buttonSignUp.isUserInteractionEnabled = false
            buttonSignUp.backgroundColor = .titleColorGray
        }

    }
        
    //MARK: 가입하기 버튼
    let buttonSignUp = UIButton()
    func setButtonSignUp() {
        buttonSignUp.setTitle("가입하기", for: .normal)
        buttonSignUp.setTitleColor(.white, for: .normal)
        buttonSignUp.layer.cornerRadius = 24
        buttonSignUp.backgroundColor = .titleColorGray
        buttonSignUp.isUserInteractionEnabled = false
        buttonSignUp.addTarget(self, action: #selector(actionSignUp), for: .touchUpInside)
        view.addSubview(buttonSignUp)
        buttonSignUp.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-105)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(UIScreen.main.bounds.width * 0.9)
            make.height.equalTo(48)
        }
    }
    @objc func actionSignUp() {
        if let textId = textFieldID.text,
           let textpassword = textFieldPassword.text,
           let textpasswordConfirm = textFieldPasswordConfirm.text,
           let textNicname = textFieldNicname.text {
            let input = CompleteSignUpInput(emailId: textId, name: textNicname, password: textpassword, passwordCheck: textpasswordConfirm, userImageUrl: nil)
            print("gogo")
            CompleteSignUpDataManager().appusers(self, input)
            
        }
        print("click")
    }
    //MARK: 약관 설명
    let labelContract = UILabel()
    func setLabelContract() {
        labelContract.text = "계정을 만들면 산타의 개인 정보 취급 방침 및 이용 약관에 동의하게 됩니다."
        labelContract.textColor = .bluegray
        labelContract.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 11)
        labelContract.textAlignment = .center
        view.addSubview(labelContract)
        labelContract.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(buttonSignUp.snp.top).offset(-15)
        }
    }
}

extension SignUpViewController {
    func successDataCheckApi(_ result : CheckNicnameResult) {
        self.presentAlert(title: result.status)
        self.boolOverlap = result.bool
        if textFieldID.text?.isEmpty == false,
           textFieldPassword.text?.isEmpty == false,
           textFieldPasswordConfirm.text?.isEmpty == false,
           textFieldNicname.text?.isEmpty == false {
            buttonSignUp.isUserInteractionEnabled = true
            buttonSignUp.backgroundColor = .mainColor
        }
        else {
            buttonSignUp.isUserInteractionEnabled = false
            buttonSignUp.backgroundColor = .titleColorGray
        }
    }
    func successDataButDontCompleteApi(_ result : CompleteSignUpEntity) {
        self.presentAlert(title: result.message)
    }
    func successDataAndCompleteApi(_ result : CompleteSignUpResult) {
        Constant.JWTToken = result.jwt
        UserDefaults.standard.set(result.jwt, forKey: "JWTToken")
        self.changeRootViewController(BaseTabbarController())
    }
    func failureDataApi() {
        self.presentAlert(title: "네트워크 통신 장애")
    }
}
