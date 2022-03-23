//
//  LoginViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/30.
//

import UIKit
import SnapKit
import KakaoSDKCommon
import AuthenticationServices
import KakaoSDKUser

class LoginViewController : BaseViewController {
    var boolautoLogin : Bool = false
    var imageViewBackground = UIImageView()
    
    override func viewDidLoad() {
        TrackingTool.Screen(screenName: "view_splash")
        
        super.viewDidLoad()
        if boolautoLogin {
            let nextVC = BaseTabbarController()
            nextVC.index = 0
            self.changeRootViewController(nextVC)
        }
        view.backgroundColor = .black
        imageSetBackground()
        viewSetLogo()
        setBottomSheet()
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
            make.centerX.equalTo(view.snp.centerX)
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
    
    // MARK: 하단 바텀 뷰
    let viewBottomSheet : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    let stackViewLoginEmail : UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .lightbluegray
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        return stackView
    }()
    func setBottomSheet() {
        view.addSubview(viewBottomSheet)
        viewBottomSheet.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view)
            make.height.equalTo(227)
        }
        
        labelSetSanta()
        buttonSetKakaoLogin()
        buttonSetAppleLogin()
        
        view.addSubview(stackViewLoginEmail)
        stackViewLoginEmail.snp.makeConstraints { make in
            make.centerX.equalTo(viewBottomSheet)
            make.width.equalTo(viewKakaoButton)
            make.height.equalTo(30)
            make.top.equalTo(buttonAppleLogin.snp.bottom).offset(18)
        }
        
        setButtonLoginID()
        setButtonCreatID()
    }
    // MARK: - 산타와함께등반해볼까요?
    let label = UILabel()
    func labelSetSanta() {
        label.text = "산타와 함께\n등산을 시작해 볼까요?"
        label.textColor = .white
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoExtraBold, size: 32)
        label.numberOfLines = 2
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(viewBottomSheet.snp.top).offset(-18)
        }
    }
    // MARK:  - 카카오톡로그인버튼
    let viewKakaoButton : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xFDE20B)
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        return view
    }()
    let  kakaoLoginButton : UIButton = {
        let button = UIButton()
        return button
    }()
    let labelKakaoLogin : UILabel = {
        let label = UILabel()
        label.text = "카카오 로그인"
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        return label
    }()
    let imageViewKakao : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "KakaoLogo@3x")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    func buttonSetKakaoLogin() {
        
        view.addSubview(viewKakaoButton)
        viewKakaoButton.snp.makeConstraints { make in
            make.centerX.equalTo(viewBottomSheet)
            make.top.equalTo(viewBottomSheet).offset(24)
            make.width.equalTo(viewBottomSheet).multipliedBy(0.9)
            make.height.equalTo(46)
        }
        
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginAction(_:)), for: .touchUpInside)
        viewKakaoButton.addSubview(kakaoLoginButton)

        kakaoLoginButton.snp.makeConstraints { make in
            make.edges.equalTo(viewKakaoButton)
        }

        viewKakaoButton.addSubview(labelKakaoLogin)
        labelKakaoLogin.snp.makeConstraints { make in
            make.bottom.equalTo(kakaoLoginButton.snp.bottom).offset(-13)
            make.top.equalTo(kakaoLoginButton.snp.top).offset(14)
            make.centerX.equalTo(kakaoLoginButton.snp.centerX).offset(13)
        }

        viewKakaoButton.addSubview(imageViewKakao)
        imageViewKakao.snp.makeConstraints { make in
            make.top.equalTo(kakaoLoginButton.snp.top).offset(17)
            make.bottom.equalTo(kakaoLoginButton.snp.bottom).offset(-15)
            make.trailing.equalTo(labelKakaoLogin.snp.leading).offset(-8)
            make.width.equalTo(17)
        }

    }
    @objc func kakaoLoginAction(_ sender : Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
               if let error = error {
                 print(error)
               }
               else {
                   
                   if let token = oauthToken {
                       print(token.accessToken)
                       self.showIndicator()
                       let input = KakaoLoginInput(accessToken: token.accessToken, pushToken: UserDefaults.standard.string(forKey: "FCM_TOKEN"), tokenType: "I")
                       KaKaoLoginDataManager().appKakaoLogin(self, input)
                   }

                //do something
                _ = oauthToken
               }
            }
          }
    }
    // MARK: 회원가입하기
    let buttonCreatID = UIButton()
    func setButtonCreatID() {
        buttonCreatID.backgroundColor = .white
        buttonCreatID.setTitle("이메일로 화원가입", for: .normal)
        buttonCreatID.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 14)
        buttonCreatID.setTitleColor(.darkbluegray, for: .normal)
        buttonCreatID.addTarget(self, action: #selector(actionGoSignUp), for: .touchUpInside)
        stackViewLoginEmail.addArrangedSubview(buttonCreatID)
    }
    @objc func actionGoSignUp() {
        let nextVC = SignUpViewController()
        TrackingTool.Action(actionName: "action_go_sign_up", param: ["goSignUp":""])
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
    // MARK: 로그인하기
    let buttonLoginID = UIButton()
    func setButtonLoginID() {
        buttonLoginID.backgroundColor = .white
        buttonLoginID.setTitle("이메일로 로그인", for: .normal)
        buttonLoginID.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 14)
        buttonLoginID.setTitleColor(.darkbluegray, for: .normal)
        stackViewLoginEmail.addArrangedSubview(buttonLoginID)
        buttonLoginID.addTarget(self, action: #selector(actionGoSignIn), for: .touchUpInside)
    }
    @objc func actionGoSignIn() {
        let nextVC = SignInViewController()
        TrackingTool.Action(actionName: "action_go_email_login", param: ["goEmailLogin":""])
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
    

    // MARK: - 애플로그인
    let buttonAppleLogin = UIButton()
    func buttonSetAppleLogin() {
        buttonAppleLogin.backgroundColor = .black
        buttonAppleLogin.addTarget(self, action: #selector(appleLoginAction), for: .touchUpInside)
        viewBottomSheet.addSubview(buttonAppleLogin)
        buttonAppleLogin.snp.makeConstraints { make in
            make.centerX.equalTo(viewBottomSheet)
            make.width.height.equalTo(viewKakaoButton)
            make.top.equalTo(viewKakaoButton.snp.bottom).offset(12)
        }
        buttonAppleLogin.layer.cornerRadius = 24
        let labelAppleLogin = UILabel()
        let imageAppleLogo = UIImageView()

        labelAppleLogin.text = "Apple로 로그인"
        labelAppleLogin.textColor = .white
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
            let code = appleIDCredential.authorizationCode
            let token = appleIDCredential.identityToken
            

            print("userIdentifier: \(userIdentifier)")
            print("fullName: \(fullName)")
            print("email: \(email)")
            print("status: \(status)")
            print("code: \(code)")
            print("token: \(token)")

            if let familyName = fullName?.familyName, let givenName = fullName?.givenName {
                let input = AppleLoginInput(name: familyName + givenName, userEmail: email ?? "", userIdentifier: userIdentifier ?? "", authorizationCode: String(data: code ?? Data(), encoding: .utf8), identifyToken: String(data: token ?? Data(), encoding: .utf8), pushToken: UserDefaults.standard.string(forKey: "FCM_TOKEN") ,tokenType: "i")
                AppleLoginDataManager().appNewApple(self, input)
            } else {
                let input = AppleLoginInput(name: "" , userEmail: email ?? "", userIdentifier: userIdentifier ?? "", authorizationCode: String(data: code ?? Data(), encoding: .utf8), identifyToken: String(data: token ?? Data(), encoding: .utf8), pushToken: UserDefaults.standard.string(forKey: "FCM_TOKEN") ,tokenType: "i")
                AppleLoginDataManager().appNewApple(self, input)
            }
            
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
//MARK: 소셜로그인 성공시
extension LoginViewController {
    func successAppleLogin(_ result : AppleLoginResult) {
        Constant.userIdx = result.userIdx
        Constant.JWTToken = result.jwt ?? ""
        UserDefaults.standard.set("Apple", forKey: "loginMethod")//최신버전 저장
        UserDefaults.standard.set(result.jwt, forKey: "JWTToken")
        self.dismissIndicator()
        self.changeRootViewController(BaseTabbarController())
    }
    
    func successKakaoLogin(_ result : KakaoLoginResult) {
        Constant.userIdx = result.userIdx
        Constant.JWTToken = result.jwt ?? ""
        UserDefaults.standard.set("Kakao", forKey: "loginMethod")//최신버전 저장
        UserDefaults.standard.set(result.jwt, forKey: "JWTToken")
        self.changeRootViewController(BaseTabbarController())
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor { return self.view.window! }
    
}
