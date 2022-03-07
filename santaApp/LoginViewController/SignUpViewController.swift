//
//  SignUpViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/14.
//

import UIKit
class SignUpViewController : BaseViewController {
    var boolOverlap : Bool = false
    var boolisitImail : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TrackingTool.Screen(screenName: "view_sign_up")
        
        self.dismissKeyboardWhenTappedAround()
        navigationBarSet()
        setLabelSantaLogo()
        setLabelSignUp()
        setTextFieldID()
        setButtonEmailCheck()
        setTextFieldPassword()
        setTextFieldPasswordConfirm()
        setTextFieldNicname()
        setButtonNicnameOverlap()
        setButtonSignUp()
        setCheckEmailGood()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(actionEmailOKAppearAndDisAppear), name: NSNotification.Name("animatedEmailCheck"), object: nil)
        setNotification()
    }
    
    @objc func actionEmailOKAppearAndDisAppear() {
        viewIDBorder.backgroundColor = .mainColor
        
        UIView.animate(withDuration: 1) {
            self.viewCheckEmailGood.alpha = 1
        } completion: { finished in
            UIView.animate(withDuration: 2, animations: {
                self.viewCheckEmailGood.alpha = 0
            }, completion: nil)
        }

    }
    override func viewDidDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("animatedEmailCheck"), object: nil)
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
        TrackingTool.Action(actionName: "action_back_sign_up", param: ["backSignUp":""])
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
    let viewIDBorder : UIView = {
        let view = UIView()
        view.backgroundColor = .lightbluegray
        return view
    }()
    
    func setTextFieldID() {
        textFieldID.delegate = self
        textFieldID.placeholder = "이메일"
        textFieldID.borderStyle = .none
        view.addSubview(textFieldID)
        textFieldID.addTarget(self, action: #selector(actionDidChangeID), for: .editingChanged)
        textFieldID.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(labelSignUp.snp.bottom).offset(34)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(34)
        }
        view.addSubview(viewIDBorder)
        viewIDBorder.snp.makeConstraints { make in
            make.top.equalTo(textFieldID.snp.bottom)
            make.leading.trailing.equalTo(textFieldID)
            make.height.equalTo(1)
        }
        
        textFieldIDExplain.text = ""
        textFieldIDExplain.textColor = .mainColor
        view.addSubview(textFieldIDExplain)
        textFieldIDExplain.snp.makeConstraints { make in
            make.leading.equalTo(textFieldID.snp.leading)
            make.top.equalTo(textFieldID.snp.bottom).offset(7)
        }
    }
    @objc func actionDidChangeID() {
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
    //MARK: 이메일 확인 버튼
    let buttonEmailCheck = UIButton()
    func setButtonEmailCheck() {
        buttonEmailCheck.setTitle("인증번호 보내기", for: .normal)
        buttonEmailCheck.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
        buttonEmailCheck.setTitleColor(.mainColor, for: .normal)
        buttonEmailCheck.layer.cornerRadius = 13
        buttonEmailCheck.layer.borderWidth = 1
        buttonEmailCheck.layer.borderColor = UIColor.mainColor.cgColor
        buttonEmailCheck.addTarget(self, action: #selector(actionEmailCheck), for: .touchUpInside)
        view.addSubview(buttonEmailCheck)
        buttonEmailCheck.snp.makeConstraints { make in
            make.centerY.equalTo(textFieldID.snp.centerY)
            make.trailing.equalTo(textFieldID.snp.trailing)
            make.height.equalTo(26)
            make.width.equalTo(92)
        }
    }
    @objc func actionEmailCheck() {
        TrackingTool.Action(actionName: "action_send_certification", param: ["sendCertification":""])
        if let text = textFieldID.text {
            let input = CheckEmailInput(email: text )
            CheckEmailDataManager().appemailcode(self, input)
        }
        self.showIndicator()
    }
    let labelEmailCheck = UILabel()
    
    //MARK: 비밀번호 입력칸
    let labelPasswordExplain = UILabel()
    let textFieldPassword = UITextField()
    let imageViewCheckPassword : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icSignupCheck")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0
        return imageView
    }()
    let viewPasswordBorder : UIView = {
        let view = UIView()
        view.backgroundColor = .lightbluegray
        return view
    }()
    func setTextFieldPassword() {
        textFieldPassword.placeholder = "비밀번호"
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.delegate = self
        textFieldPassword.addTarget(self, action: #selector(actiondidChangeShowLabel), for: .editingChanged)
        view.addSubview(textFieldPassword)
        textFieldPassword.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(textFieldID.snp.bottom).offset(28)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(34)
        }
        view.addSubview(viewPasswordBorder)
        viewPasswordBorder.snp.makeConstraints { make in
            make.top.equalTo(textFieldPassword.snp.bottom)
            make.leading.trailing.equalTo(textFieldPassword)
            make.height.equalTo(1)
        }
        view.addSubview(imageViewCheckPassword)
        imageViewCheckPassword.snp.makeConstraints { make in
            make.centerY.equalTo(textFieldPassword)
            make.width.height.equalTo(24)
            make.trailing.equalTo(textFieldPassword)
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
        viewPasswordBorder.backgroundColor = .mainColor
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
                imageViewCheckPassword.alpha = 1
            }
            else {
                labelPasswordExplain.text = "8~16자로 입력해주세요."
                imageViewCheckPassword.alpha = 0
            }
        }

    }
    //MARK: 비밀번호 확인 입력칸
    let textFieldPasswordConfirm = UITextField()
    let labelPasswordConfirm = UILabel()
    let imageViewCheckPasswordConfirm : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icSignupCheck")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0
        return imageView
    }()
    let viewPasswordCheckBorder : UIView = {
        let view = UIView()
        view.backgroundColor = .lightbluegray
        return view
    }()
    func setTextFieldPasswordConfirm() {
        textFieldPasswordConfirm.placeholder = "비밀번호 확인"
        textFieldPasswordConfirm.isSecureTextEntry = true
        textFieldPasswordConfirm.delegate = self
        textFieldPasswordConfirm.addTarget(self, action: #selector(actiondidConfirmShowLabel), for: .editingChanged)
        view.addSubview(textFieldPasswordConfirm)
        textFieldPasswordConfirm.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(textFieldPassword.snp.bottom).offset(27)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(34)
        }
        
        view.addSubview(imageViewCheckPasswordConfirm)
        imageViewCheckPasswordConfirm.snp.makeConstraints { make in
            make.centerY.equalTo(textFieldPasswordConfirm)
            make.trailing.equalTo(textFieldPasswordConfirm)
            make.width.equalTo(24)
        }
        view.addSubview(viewPasswordCheckBorder)
        viewPasswordCheckBorder.snp.makeConstraints { make in
            make.top.equalTo(textFieldPasswordConfirm.snp.bottom)
            make.leading.trailing.equalTo(textFieldPasswordConfirm)
            make.height.equalTo(1)
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
                viewPasswordCheckBorder.backgroundColor = .mainColor
                labelPasswordConfirm.text = "비밀번호가 일치합니다."
                labelPasswordConfirm.textColor = .mainColor
                imageViewCheckPasswordConfirm.alpha = 1
            }
            else {
                viewPasswordCheckBorder.backgroundColor = .coral
                labelPasswordConfirm.text = "비밀번호가 일치하지 않습니다."
                labelPasswordConfirm.textColor = .red
                imageViewCheckPasswordConfirm.alpha = 0
                
            }
        }
    }
    //MARK: 닉네임 입력칸
    let textFieldNicname = UITextField()
    let labelCheckNicNameOverlap : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 13)
        label.textColor = .mainColor
        label.alpha = 0
        return label
    }()
    let viewNickNameBorder : UIView = {
        let view = UIView()
        view.backgroundColor = .lightbluegray
        return view
    }()
    func setTextFieldNicname() {
        textFieldNicname.placeholder = "닉네임(중복 불가)"
        textFieldNicname.delegate = self
        textFieldNicname.addTarget(self, action: #selector(actiondidChangeNicname), for: .editingChanged)
        
        view.addSubview(textFieldNicname)
        textFieldNicname.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(textFieldPasswordConfirm.snp.bottom).offset(28)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(34)
        }
        
        view.addSubview(viewNickNameBorder)
        viewNickNameBorder.snp.makeConstraints { make in
            make.top.equalTo(textFieldNicname.snp.bottom)
            make.leading.trailing.equalTo(textFieldNicname)
            make.height.equalTo(1)
        }
        
        view.addSubview(labelCheckNicNameOverlap)
        labelCheckNicNameOverlap.snp.makeConstraints { make in
            make.leading.equalTo(textFieldNicname)
            make.top.equalTo(textFieldNicname.snp.bottom).offset(9)
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
        TrackingTool.Action(actionName: "action_nickname_duplicate", param: ["nickNameDuplicate":""])
        if let text = textFieldNicname.text {
            if text.isEmpty == false {
                let input = CheckNicnameInput(name: text)
                CheckNicnameDataManager().appUsersNameCheck(self, input)
            }
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
        TrackingTool.Action(actionName: "action_do_sign_up", param: ["doSignUp":""])
        if let textId = textFieldID.text,
           let textpassword = textFieldPassword.text,
           let textpasswordConfirm = textFieldPasswordConfirm.text,
           let textNicname = textFieldNicname.text {
            let input = CompleteSignUpInput(emailId: textId, name: textNicname, password: textpassword, passwordCheck: textpasswordConfirm, userImageUrl: nil)
            CompleteSignUpDataManager().appusers(self, input)
            
        }
    }

    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil) }
    var fCurTextfieldBottom: CGFloat = 0.0
    
    @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               if fCurTextfieldBottom <= self.view.frame.height - keyboardSize.height {
                   return
               }
               if self.view.frame.origin.y == 0 {
                   self.view.frame.origin.y -= keyboardSize.height
               }
           }
       }
    @objc func keyboardWillHide(notification: NSNotification) {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    //MARK: 이메일 체인증 완료시 나오는 뷰
    let viewCheckEmailGood : UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.darkbluegray.cgColor
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.lightbluegray.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 3)
        view.layer.shadowOpacity = 0.49
        view.layer.shadowRadius = 9
        view.alpha = 0
        return view
    }()
    
    let labelExplainCheckGood: UILabel = {
        let label = UILabel()
        label.text = "이메일 인증이 완료되었습니다."
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 14)
        label.addCharacterSpacing(kernValue: -0.28)
        return label
    }()
    
    let imageViewCheck : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icSignupCheckboxCircle")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func setCheckEmailGood() {
        view.addSubview(viewCheckEmailGood)
        viewCheckEmailGood.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(49)
            make.width.equalTo(328)
            make.height.equalTo(54)
        }
        
        viewCheckEmailGood.addSubview(imageViewCheck)
        imageViewCheck.snp.makeConstraints { make in
            make.centerY.equalTo(viewCheckEmailGood)
            make.leading.equalTo(viewCheckEmailGood).offset(15.2)
            make.width.height.equalTo(32)
        }
        
        viewCheckEmailGood.addSubview(labelExplainCheckGood)
        labelExplainCheckGood.snp.makeConstraints { make in
            make.centerY.equalTo(viewCheckEmailGood)
            make.leading.equalTo(imageViewCheck.snp.trailing).offset(5.8)
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
            fCurTextfieldBottom = textField.frame.origin.y + textField.frame.height
        }

    // MARK: 닉네임 체크 API
    func successDataCheckApi(_ result : CheckNicnameResult) {
        if result.bool {
            labelCheckNicNameOverlap.textColor = .mainColor
            viewNickNameBorder.backgroundColor = .mainColor
        } else {
            labelCheckNicNameOverlap.textColor = .coral
            viewNickNameBorder.backgroundColor = .coral
        }
        self.labelCheckNicNameOverlap.text = result.status
        self.labelCheckNicNameOverlap.alpha = 1
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
    // MARK: 이메일 보내기 성공~
    func successDataApiCheckImailPost(_ message : String) {
        let nextVC = CheckNumberViewController()
        nextVC.email = textFieldID.text ?? ""
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: false, completion: nil)
        self.dismissIndicator()
    }
    
    // MARK: 가입하기 실패
    func successDataButDontCompleteApi(_ result : CompleteSignUpEntity) {
        self.presentAlert(title: result.message)
    }
    //MARK: 가입하기 성공
    func successDataAndCompleteApi(_ result : CompleteSignUpResult) {
        Constant.JWTToken = result.jwt
        UserDefaults.standard.set(result.jwt, forKey: "JWTToken")
        Constant.userIdx = result.userIdx
        Constant.userEmail = textFieldID.text!
        self.changeRootViewController(BaseTabbarController())
    }
    func failureDataApi(_ message : String) {
        self.presentAlert(title: message)
        self.dismissIndicator()
    }
}
