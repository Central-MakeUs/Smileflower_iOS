//
//  FlagExplainViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/26.
//

import UIKit

class CheckNumberViewController : UIViewController {
    var email : String = ""
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.alpha = 0.7
            return view
        }()
      
      // 2
      override func viewDidLoad() {
          super.viewDidLoad()
          setupUI()
        viewSetContent()
          setContent()
          setButtonDismiss()
      }
    
      // 3
      private func setupUI() {
          view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
      }
    // MARK: 내용이 들어갈 뷰
    let viewContent = UIView()
    func viewSetContent() {
        viewContent.layer.cornerRadius = 25
        viewContent.backgroundColor = .white
        view.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).offset(-17.5)
            make.width.equalTo(280)
            make.height.equalTo(153)
        }
    }
    let labelExplain : UILabel = {
        let label = UILabel()
        label.text = "인증번호 4자리가 발송되었어요."
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 16)
        label.textColor = .darkbluegray
        return label
    }()
    let viewTextFieldBackground : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.lightbluegray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    
    let textFieldNumber : UITextField = {
        let textField = UITextField()
        textField.placeholder = "인증번호 4자리 입력"
        textField.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        return textField
    }()
    @objc func actionDidChanged(textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count > 4 {
            textField.deleteBackward()
        }
        else if text.count == 4 {
            buttonCheck.isEnabled = true
            buttonCheck.backgroundColor = .mainColor
        } else {
            buttonCheck.isEnabled = false
            buttonCheck.backgroundColor = .lightbluegray
        }
    }

    let buttonCheck : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.isEnabled = false
        button.backgroundColor = .lightbluegray
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    @objc func actionCheck() {
        if let text = textFieldNumber.text {
            let input = CertificationNumberInput(email: self.email, code: Int(text) ?? 0)
            CertificationNumberDataManager().appemilverify(self, input)
        }
    }
    
    let labelDidNotCertificationNumber : UILabel =  {
        let label = UILabel()
        label.text = "인증번호가 올바르지 않습니다."
        label.textColor = .coral
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 11)
        label.alpha = 0
        return label
    }()
    
    func setContent() {
        viewContent.addSubview(labelExplain)
        labelExplain.snp.makeConstraints { make in
            make.centerX.equalTo(viewContent)
            make.top.equalTo(viewContent).offset(42)
        }
        
        textFieldNumber.delegate = self
        textFieldNumber.addTarget(self, action: #selector(actionDidChanged(textField:)), for: .editingChanged)
        viewContent.addSubview(viewTextFieldBackground)
        viewTextFieldBackground.snp.makeConstraints { make in
            make.centerX.equalTo(viewContent)
            make.top.equalTo(labelExplain.snp.bottom).offset(16)
            make.width.equalTo(242)
            make.height.equalTo(42)
        }
        
        viewContent.addSubview(textFieldNumber)
        textFieldNumber.snp.makeConstraints { make in
            make.width.equalTo(180)
            make.height.equalTo(20)
            make.centerY.equalTo(viewTextFieldBackground)
            make.leading.equalTo(viewTextFieldBackground).offset(12)
        }
        
        buttonCheck.addTarget(self, action: #selector(actionCheck), for: .touchUpInside)
        viewContent.addSubview(buttonCheck)
        buttonCheck.snp.makeConstraints { make in
            make.width.equalTo(58)
            make.height.equalTo(32)
            make.centerY.equalTo(viewTextFieldBackground)
            make.trailing.equalTo(viewTextFieldBackground).offset(-5)
        }
        
        viewContent.addSubview(labelDidNotCertificationNumber)
        labelDidNotCertificationNumber.snp.makeConstraints { make in
            make.leading.equalTo(viewTextFieldBackground)
            make.top.equalTo(viewTextFieldBackground.snp.bottom).offset(4)
        }
    }
    //MARK: 창 지우기
    let buttonDismiss = UIButton()
    func setButtonDismiss() {
        buttonDismiss.setImage(UIImage(systemName: "xmark"), for: .normal)
        buttonDismiss.addTarget(self, action: #selector(actionDismiss), for: .touchUpInside)
        buttonDismiss.tintColor = .lightbluegray
        viewContent.addSubview(buttonDismiss)
        buttonDismiss.snp.makeConstraints { make in
            make.top.equalTo(viewContent).offset(15)
            make.trailing.equalTo(viewContent).offset(-15)
            make.width.height.equalTo(26)
        }
    }
    @objc func actionDismiss() {
        self.dismiss(animated: false, completion: nil)
    }
}


extension CheckNumberViewController : UITextFieldDelegate {
    // MARK: 인증번호 성공
    func successDataApiCertification(_ message: String) {
        NotificationCenter.default.post(name: NSNotification.Name("animatedEmailCheck"), object: nil)
        self.dismiss(animated: false, completion: nil)
    }
    func failureDataApiCeritfication(_ message: String) {
        viewTextFieldBackground.layer.borderColor = UIColor.coral.cgColor
        labelDidNotCertificationNumber.alpha = 1
    }
}
