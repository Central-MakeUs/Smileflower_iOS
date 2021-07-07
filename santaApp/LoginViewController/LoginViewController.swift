//
//  LoginViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/30.
//

import UIKit
import SnapKit
import KakaoSDKAuth
import AuthenticationServices

class LoginViewController : BaseViewController {
    var kakaoLoginButton = UIButton()
    var loginProviderStackView = UIStackView()
    
    var imageViewBackground = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        imageSetBackground()
        
        buttonSetAppleLogin()
        buttonSetKakaoLogin()
        labelSetSanta()
        viewSetLogo()
        
    }
    // MARK : - 뒷 배경
    func imageSetBackground() {
//        imageViewBackground.clipsToBounds = true
        let imageLogin = UIImage(named: "로그인화면5")
        imageViewBackground.image = imageLogin
        imageViewBackground.contentMode = .scaleAspectFill
        view.addSubview(imageViewBackground)
        
        imageViewBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    // MARK : - 산타 로고
    func viewSetLogo() {
        let labelUp = UILabel()
        let labelSanta = UILabel()
        let imageSantaLogo = UIImageView()
        
        labelUp.text = "우리 같이"
        labelUp.textColor = .white
        labelUp.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 17)
        labelUp.textAlignment = .center
        view.addSubview(labelUp)
        labelUp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(122)
        }
        
        labelSanta.text = "SANTA"
        labelSanta.textColor = .white
        labelSanta.font = UIFont(name: Constant.fontCocogoose, size: 33)
        labelSanta.addCharacterSpacing()
        labelSanta.textAlignment = .center
        view.addSubview(labelSanta)
        labelSanta.snp.makeConstraints { make in
            make.centerX.equalTo(labelUp.snp.centerX)
            make.top.equalTo(labelUp.snp.bottom).offset(-1.65)
        }
        
    imageSantaLogo.image = UIImage(named: "1002@3x")
        view.addSubview(imageSantaLogo)
        imageSantaLogo.snp.makeConstraints { make in
            make.top.equalTo(labelSanta.snp.bottom)
            make.width.equalTo(134.7)
            make.height.equalTo(65.7)
            make.centerX.equalTo(labelUp.snp.centerX)
        }
    }
    // MARK : - 산타와함께등반해볼까요?
    func labelSetSanta() {
        let label = UILabel()
        label.text = "산타와 함께\n등산을 시작해 볼까요?"
        label.textColor = .white
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoExtraBold, size: 32)
        label.numberOfLines = 2
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.bottom.equalTo(kakaoLoginButton.snp.top).offset(-21)
            make.leading.equalTo(view.snp.leading).offset(28)
        }
    }
    
    // MARK :  - 카카오톡로그인버튼
    func buttonSetKakaoLogin() {
        let labelKakaoLogin = UILabel()
        let imageKakaoLogo = UIImageView()
        
        kakaoLoginButton.backgroundColor = UIColor(hex: 0xFDE20B)
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginAction(_:)), for: .touchUpInside)
        view.addSubview(kakaoLoginButton)
        kakaoLoginButton.layer.cornerRadius = 24
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.width.equalTo(loginProviderStackView.snp.width)
            make.height.equalTo(loginProviderStackView.snp.height)
            make.centerX.equalTo(loginProviderStackView.snp.centerX)
            make.bottom.equalTo(loginProviderStackView.snp.top).offset(-10)
        }
        
        labelKakaoLogin.text = "카카오 로그인"
        labelKakaoLogin.textColor = .black
        labelKakaoLogin.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        kakaoLoginButton.addSubview(labelKakaoLogin)
        labelKakaoLogin.snp.makeConstraints { make in
            make.bottom.equalTo(kakaoLoginButton.snp.bottom).offset(-13)
            make.top.equalTo(kakaoLoginButton.snp.top).offset(14)
            make.centerX.equalTo(kakaoLoginButton.snp.centerX).offset(13)
        }
        
        imageKakaoLogo.image = UIImage(named: "KakaoLogo@3x")
    imageKakaoLogo.contentMode = .scaleAspectFit
        kakaoLoginButton.addSubview(imageKakaoLogo)
        imageKakaoLogo.snp.makeConstraints { make in
            make.top.equalTo(kakaoLoginButton.snp.top).offset(17)
        make.bottom.equalTo(kakaoLoginButton.snp.bottom).offset(-15)
            make.trailing.equalTo(labelKakaoLogin.snp.leading).offset(-8)
            make.width.equalTo(17)
        }
        
    }
    @objc func kakaoLoginAction(_ sender : Any) {
        AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
           if let error = error {
             print(error)
           }
           else {
            print("loginWithKakaoAccount() success.")
            
            //do something
            _ = oauthToken
           }
        }
    }
    
    // MARK : - 애플로그인
    func buttonSetAppleLogin() {
        self.loginProviderStackView.axis = .horizontal
        self.loginProviderStackView.alignment = .fill
        self.loginProviderStackView.distribution = .fillEqually
        self.loginProviderStackView.spacing = 0
        self.loginProviderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loginProviderStackView)
        view.bringSubviewToFront(loginProviderStackView)
        loginProviderStackView.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.leading.equalTo(self.view.snp.leading).offset(17)
            make.trailing.equalTo(self.view.snp.trailing).offset(-17)
            make.bottom.equalTo(self.view.snp.bottom).offset(-86)
        }
        loginProviderStackView.layer.zPosition = 999
//        loginProviderStackView.translatesAutoresizingMaskIntoConstraints = true
        
//        let authorizationButton = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
//        authorizationButton.cornerRadius = 24
//        authorizationButton.addTarget(self, action: #selector(appleLoginAction), for: .touchUpInside)
//        loginProviderStackView.addArrangedSubview(authorizationButton)
        
        let buttonAppleLogin = UIButton()
        buttonAppleLogin.backgroundColor = .white
        buttonAppleLogin.addTarget(self, action: #selector(appleLoginAction), for: .touchUpInside)
        loginProviderStackView.addArrangedSubview(buttonAppleLogin)
        buttonAppleLogin.layer.cornerRadius = 24
        let labelAppleLogin = UILabel()
        let imageAppleLogo = UIImageView()
        
        labelAppleLogin.text = "Apple로 로그인"
        labelAppleLogin.textColor = .black
        labelAppleLogin.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        buttonAppleLogin.addSubview(labelAppleLogin)
        labelAppleLogin.snp.makeConstraints { make in
            make.centerX.equalTo(buttonAppleLogin.snp.centerX).offset(13)
            make.top.equalTo(buttonAppleLogin.snp.top).offset(15)
            make.bottom.equalTo(buttonAppleLogin.snp.bottom).offset(-12)
        }

        imageAppleLogo.image = UIImage(named: "appleLogo@3x")
        buttonAppleLogin.addSubview(imageAppleLogo)
        imageAppleLogo.contentMode = .scaleAspectFill
        imageAppleLogo.snp.makeConstraints { make in
            make.centerY.equalTo(labelAppleLogin.snp.centerY)
            make.top.equalTo(buttonAppleLogin.snp.top).offset(10)
            make.bottom.equalTo(buttonAppleLogin.snp.bottom).offset(-9)
            make.width.equalTo(16)
            make.trailing.equalTo(labelAppleLogin.snp.leading).offset(-8)
        }
    }
    @objc
    func appleLoginAction() {
        print("hi")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
          let request = appleIDProvider.createRequest()
          request.requestedScopes = [.fullName, .email]
                
          let authorizationController = ASAuthorizationController(authorizationRequests: [request])
          authorizationController.delegate = self
          authorizationController.presentationContextProvider = self
          authorizationController.performRequests()
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        
        // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // 계정 정보 가져오기
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let status = appleIDCredential.realUserStatus
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            print("UserStatus : \(status)")
     
            self.changeRootViewController(BaseTabbarController())
        default:
            break
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor { return self.view.window! }
    
}
