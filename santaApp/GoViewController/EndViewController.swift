//
//  EndViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/02.
//

import UIKit
import MobileCoreServices
import Lottie
import CoreLocation

class EndViewController : BaseViewController {
    let picker = UIImagePickerController()
    var flagImageSave = false
    var mountainIdx : Int?
    var mountainTopAltitude : Int = 0
    var mountainNowAltitude : Int = 0
    var nowLatitude : Double = 0
    var nowLogitude : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserPosition()
        picker.delegate = self
        navigationBarSet()
        setAnimation()
        setLabelHiking()
        setStackViewAltitude()
        setViewAltitudeCheck()
        setButton()
        setViewExplainCamera()
    }

    override func viewWillLayoutSubviews() {
        viewAltitudeCheck.setverticleAndCornerGradient(color1:  UIColor(hex: 0x24C7B9), color2: UIColor(hex: 0x9AC7FF), cornerRadius: 21)
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .userInteractive).async {
            while true {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.1) {
                        
                        switch Constant.userPhoneHeight {
                    // 아이폰 6
                            case 667:
                                self.viewAltitudeCheck.frame = CGRect(x: 24, y: 471.9, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
                    // 아이폰 8 플러스
                            case 736:
                                self.viewAltitudeCheck.frame = CGRect(x: 24, y: 525.7, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
                    // 아이폰 11 프로
                            case 812:
                                self.viewAltitudeCheck.frame = CGRect(x: 24, y: 590, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
                    // 아이폰 12
                            case 844:
                                self.viewAltitudeCheck.frame = CGRect(x: 31.5, y: 590, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
                    // 아이폰 11
                            case 896:
                                self.viewAltitudeCheck.frame = CGRect(x: 43.5, y: 635.2, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
                    // 아이폰 12 프로 플러스
                            case 926:
                                self.viewAltitudeCheck.frame = CGRect(x: 50.5, y: 662.2, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
                            default:
                                self.viewAltitudeCheck.frame = CGRect(x: 24, y: 542.9, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
                        }
                        if self.mountainNowAltitude > Int(self.mountainTopAltitude * 2 / 5) {
                            self.buttonCamera.tintColor = .mainColor
                            self.buttonCamera.layer.borderColor = UIColor.mainColor.cgColor
                            
                            self.buttonDismiss.tintColor = UIColor(hex: 0xc9d4e2)
                            self.buttonDismiss.layer.borderColor = UIColor(hex: 0xc9d4e2).cgColor
                            self.buttonDismiss.isEnabled = false
                        }
                        else {
                            self.buttonCamera.tintColor = UIColor(hex: 0xc9d4e2)
                            self.buttonCamera.layer.borderColor = UIColor(hex: 0xc9d4e2).cgColor
                            
                            self.buttonDismiss.tintColor = .mainColor
                            self.buttonDismiss.layer.borderColor = UIColor.mainColor.cgColor
                            self.buttonDismiss.isEnabled = true
                        }
                    }
                    
                }
                usleep(1000000)
            }
        }
    }
    // MARK: 위치정보 받아오기
    var locationManager = CLLocationManager()
    func getUserPosition() {
        locationManager.delegate = self
        // 거리 정확도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        // 아이폰 설정에서의 위치 서비스가 켜진 상태라면
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
        } else {
            print("위치 서비스 off 상태")
        }
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
        let vc = BaseTabbarController()
        vc.index = 2
        self.changeRootViewController(vc)
    }
    
    // MARK: 애니메이션
    func setAnimation() {
        let animationView = AnimationView(name: "lottieAnimaition")
        view.addSubview(animationView)
        switch Constant.userPhoneHeight {
        // 아이폰 6
            case 667:
                animationView.frame = CGRect(x: UIScreen.main.bounds.width/2 - 35.2, y: 205.8, width: 70.4, height: 141.7)
        // 아이폰 8 플러스
            case 736:
                animationView.frame = CGRect(x: UIScreen.main.bounds.width/2 - 43.2, y: 243.8, width: 86.4, height: 149)
        // 아이폰 11 프로
            case 812:
                animationView.frame = CGRect(x: UIScreen.main.bounds.width/2 - 43.2, y: 289, width: 86.4, height: 149)
        // 아이폰 12
            case 844:
                animationView.frame = CGRect(x: UIScreen.main.bounds.width/2 - 43.2, y: 289, width: 86.4, height: 149)
        // 아이폰 11
            case 896:
                animationView.frame = CGRect(x: UIScreen.main.bounds.width/2 - 45, y: 303.2, width: 90, height: 160)
        // 아이폰 12 프로 플러스
            case 926:
                animationView.frame = CGRect(x: UIScreen.main.bounds.width/2 - 55, y: 325.3, width: 110, height: 216)
            default:
                animationView.frame = CGRect(x: UIScreen.main.bounds.width/2 - 55, y: UIScreen.main.bounds.height/2 - 108, width: 110, height: 216)
        }
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
    }
    //MARK: 도착 라벨
    let labelHiking = UILabel()
    let labelMountain = UILabel()
    let imageViewPosition = UIImageView()
    func setLabelHiking() {
        labelHiking.text = "등산중"
        labelHiking.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 64)
        labelHiking.textAlignment = .center
        labelHiking.textColor = .darkbluegray
        view.addSubview(labelHiking)
        switch Constant.userPhoneHeight {
        // 아이폰 6
            case 667:
                labelHiking.snp.makeConstraints { make in
                    make.top.equalTo(view.snp.top).offset(118.6)
                    make.centerX.equalTo(view.snp.centerX)
                }
        // 아이폰 8 플러스
            case 736:
                labelHiking.snp.makeConstraints { make in
                    make.bottom.equalTo(view.snp.centerY).offset(-156)
                    make.centerX.equalTo(view.snp.centerX)
                }
        // 아이폰 11 프로
            case 812:
                labelHiking.snp.makeConstraints { make in
                    make.bottom.equalTo(view.snp.centerY).offset(-156)
                    make.centerX.equalTo(view.snp.centerX)
                }
        // 아이폰 12
            case 844:
                labelHiking.snp.makeConstraints { make in
                    make.top.equalTo(view.snp.top).offset(164.9)
                    make.centerX.equalTo(view.snp.centerX)
                }
        // 아이폰 11
            case 896:
                labelHiking.snp.makeConstraints { make in
                    make.top.equalTo(view.snp.top).offset(164.9)
                    make.centerX.equalTo(view.snp.centerX)
                }
        // 아이폰 12 프로 플러스
            case 926:
                labelHiking.snp.makeConstraints { make in
                    make.top.equalTo(view.snp.top).offset(188.8)
                    make.centerX.equalTo(view.snp.centerX)
                }
            default:
                labelHiking.snp.makeConstraints { make in
                    make.bottom.equalTo(view.snp.centerY).offset(-156)
                    make.centerX.equalTo(view.snp.centerX)
                }
        }
        labelMountain.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 27)
        labelMountain.textColor = .darkbluegray
        view.addSubview(labelMountain)
        labelMountain.snp.makeConstraints { make in
            make.bottom.equalTo(labelHiking.snp.top).offset(-5.6)
            make.centerX.equalTo(labelHiking.snp.centerX).offset(10)
        }
        imageViewPosition.image = UIImage(named: "position@3x")
        imageViewPosition.contentMode = .scaleAspectFit
        view.addSubview(imageViewPosition)
        imageViewPosition.snp.makeConstraints { make in
            make.trailing.equalTo(labelMountain.snp.leading).offset(-6.6)
            make.centerY.equalTo(labelMountain)
            make.width.equalTo(22.9)
            make.height.equalTo(27.7)
        }
    }
    
    func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    //MARK: 고도
    let stackViewAltitude = UIStackView()
    let viewNowAltitude = UIView()
    let viewTopAltitude = UIView()
    
    let labelNow = UILabel()
    let labelTop = UILabel()
    
    let labelTopAltitude = UILabel()
    let labelNowAltitude = UILabel()
    
    func setStackViewAltitude() {
        self.stackViewAltitude.backgroundColor = UIColor(hex: 0xc1cad0, alpha: 1)
        self.stackViewAltitude.axis = .horizontal
        self.stackViewAltitude.alignment = .fill
        self.stackViewAltitude.distribution = .fillEqually
        self.stackViewAltitude.spacing = 1
        
        viewNowAltitude.backgroundColor = .white
        viewTopAltitude.backgroundColor = .white
        
        //MARK: 현재 고도
        labelNow.text = "현재 고도"
        labelNow.textColor = .titleColorGray
        labelNow.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 14)
        
        viewNowAltitude.addSubview(labelNow)
        labelNow.snp.makeConstraints { make in
            make.centerX.equalTo(viewNowAltitude.snp.centerX)
            make.top.equalTo(viewNowAltitude.snp.top)
        }
        
        labelNowAltitude.textColor = . darkbluegray
        labelNowAltitude.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 50)
        labelNowAltitude.textAlignment = .center
        
        viewNowAltitude.addSubview(labelNowAltitude)
        labelNowAltitude.snp.makeConstraints { make in
            make.centerX.equalTo(labelNow.snp.centerX)
            make.top.equalTo(labelNow.snp.bottom).offset(5)
            make.width.equalTo(108)
            make.height.equalTo(47)
        }
        
        //MARK: 정상 고도
        labelTop.text = "정상까지"
        labelTop.textColor = .titleColorGray
        labelTop.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 14)
        
        labelTopAltitude.text = String(mountainTopAltitude)
        labelTopAltitude.textColor = .darkbluegray
        labelTopAltitude.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 50)
        labelTopAltitude.textAlignment = .center
        
        viewTopAltitude.addSubview(labelTop)
        labelTop.snp.makeConstraints { make in
            make.centerX.equalTo(viewTopAltitude.snp.centerX)
            make.top.equalTo(viewTopAltitude.snp.top)
        }
        
        viewTopAltitude.addSubview(labelTopAltitude)
        labelTopAltitude.snp.makeConstraints { make in
            make.centerX.equalTo(labelTop.snp.centerX)
            make.top.equalTo(labelTop.snp.bottom).offset(5)
            make.width.equalTo(108)
            make.height.equalTo(47)
        }
        
        view.addSubview(stackViewAltitude)
        
        switch Constant.userPhoneHeight {
        // 아이폰 6
            case 667:
                stackViewAltitude.snp.makeConstraints { make in
                    make.centerX.equalTo(labelHiking.snp.centerX)
                    make.top.equalTo(view).offset(380.9)
                    make.width.equalTo(321)
                    make.height.equalTo(74)
                }
        // 아이폰 8 플러스
            case 736:
                stackViewAltitude.snp.makeConstraints { make in
                    make.centerX.equalTo(labelHiking.snp.centerX)
                    make.top.equalTo(view).offset(434.7)
                    make.width.equalTo(321)
                    make.height.equalTo(74)
                }
        // 아이폰 11 프로
            case 812:
                stackViewAltitude.snp.makeConstraints { make in
                    make.centerX.equalTo(labelHiking.snp.centerX)
                    make.top.equalTo(view).offset(499)
                    make.width.equalTo(321)
                    make.height.equalTo(74)
                }
        // 아이폰 12
            case 844:
                stackViewAltitude.snp.makeConstraints { make in
                    make.centerX.equalTo(labelHiking.snp.centerX)
                    make.top.equalTo(view).offset(499)
                    make.width.equalTo(321)
                    make.height.equalTo(74)
                }
        // 아이폰 11
            case 896:
                stackViewAltitude.snp.makeConstraints { make in
                    make.centerX.equalTo(labelHiking.snp.centerX)
                    make.top.equalTo(view).offset(544.2)
                    make.width.equalTo(321)
                    make.height.equalTo(74)
                }
        // 아이폰 12 프로 플러스
            case 926:
                stackViewAltitude.snp.makeConstraints { make in
                    make.centerX.equalTo(labelHiking.snp.centerX)
                    make.top.equalTo(view).offset(571.2)
                    make.width.equalTo(321)
                    make.height.equalTo(74)
                }
            default:
                stackViewAltitude.snp.makeConstraints { make in
                    make.centerX.equalTo(labelHiking.snp.centerX)
                    make.top.equalTo(view).offset(557)
                    make.width.equalTo(321)
                    make.height.equalTo(74)
                }
        }
        
        stackViewAltitude.addArrangedSubview(viewNowAltitude)
        stackViewAltitude.addArrangedSubview(viewTopAltitude)
    }
    //MARK: 고도 확인 뷰
    let viewBackgroundAltitude = UIView()
    let viewAltitudeCheck = UIView()
    let imageViewFlag = UIImageView()
    let imageViewLine = UIImageView()
    
    func setViewAltitudeCheck() {
        viewBackgroundAltitude.backgroundColor =  .lightbluegray
        viewBackgroundAltitude.layer.cornerRadius = 21
        view.addSubview(viewBackgroundAltitude)
        view.addSubview(viewAltitudeCheck)
        viewAltitudeCheck.layer.zPosition = 999
        switch Constant.userPhoneHeight {
        // 아이폰 6
                case 667:
                    viewBackgroundAltitude.snp.makeConstraints { make in
                        make.width.equalTo(327)
                        make.height.equalTo(42)
                        make.centerX.equalTo(view.snp.centerX)
                        make.top.equalTo(view.snp.top).offset(471.9)
                    }
                    self.viewAltitudeCheck.frame = CGRect(x: 24, y: 471.9, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
        // 아이폰 8 플러스
                case 736:
                    viewBackgroundAltitude.snp.makeConstraints { make in
                        make.width.equalTo(327)
                        make.height.equalTo(42)
                        make.centerX.equalTo(view.snp.centerX)
                        make.top.equalTo(view.snp.top).offset(523.7)
                    }
                    self.viewAltitudeCheck.frame = CGRect(x: 24, y: 523.7, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
        // 아이폰 11 프로
                case 812:
                    viewBackgroundAltitude.snp.makeConstraints { make in
                        make.width.equalTo(327)
                        make.height.equalTo(42)
                        make.centerX.equalTo(view.snp.centerX)
                        make.top.equalTo(view.snp.top).offset(590)
                    }
                    self.viewAltitudeCheck.frame = CGRect(x: 24, y: 590, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
        // 아이폰 12
                case 844:
                    viewBackgroundAltitude.snp.makeConstraints { make in
                        make.width.equalTo(327)
                        make.height.equalTo(42)
                        make.centerX.equalTo(view.snp.centerX)
                        make.top.equalTo(view.snp.top).offset(590)
                    }
                    self.viewAltitudeCheck.frame = CGRect(x: 24, y: 590, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
        // 아이폰 11
                case 896:
                    viewBackgroundAltitude.snp.makeConstraints { make in
                        make.width.equalTo(327)
                        make.height.equalTo(42)
                        make.centerX.equalTo(view.snp.centerX)
                        make.top.equalTo(view.snp.top).offset(635.2)
                    }
                    self.viewAltitudeCheck.frame = CGRect(x: 43.5, y: 635.2, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
        // 아이폰 12 프로 플러스
                case 926:
                    viewBackgroundAltitude.snp.makeConstraints { make in
                        make.width.equalTo(327)
                        make.height.equalTo(42)
                        make.centerX.equalTo(view.snp.centerX)
                        make.top.equalTo(view.snp.top).offset(662.2)
                    }
                    self.viewAltitudeCheck.frame = CGRect(x: 50.5, y: 662.2, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
                default:
                    viewBackgroundAltitude.snp.makeConstraints { make in
                        make.width.equalTo(327)
                        make.height.equalTo(42)
                        make.centerX.equalTo(view.snp.centerX)
                        make.top.equalTo(view.snp.top).offset(542.9)
                    }
                    self.viewAltitudeCheck.frame = CGRect(x: 24, y: 542.9, width: Double(327 * self.mountainNowAltitude / self.mountainTopAltitude), height: 42)
                }
        imageViewFlag.image = UIImage(named: "FlagIcon@3x")
        viewBackgroundAltitude.addSubview(imageViewFlag)
        imageViewFlag.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalTo(viewBackgroundAltitude.snp.leading).offset(125.6)
            make.centerY.equalTo(viewBackgroundAltitude.snp.centerY)
        }
        imageViewLine.image = UIImage(named: "icHikingLine@3x")
        viewBackgroundAltitude.addSubview(imageViewLine)
        imageViewLine.snp.makeConstraints { make in
            make.centerX.equalTo(viewBackgroundAltitude.snp.centerX)
            make.width.equalTo(viewBackgroundAltitude.snp.width).multipliedBy(0.6)
            make.top.equalTo(viewBackgroundAltitude.snp.top)
            make.height.equalTo(10)
        }
        imageViewLine.layer.zPosition = 999
    }
    //MARK: 사진 찍기 버튼 과 그만하기 버튼
    let buttonDismiss = UIButton()
    let buttonCamera = UIButton()
    
    func setButton() {
        let configCamera = UIImage.SymbolConfiguration(
            pointSize: 30, weight: .medium, scale: .default)
        let imageCamera = UIImage(systemName: "camera.fill", withConfiguration: configCamera)
        buttonCamera.setImage(imageCamera, for: .normal)
        buttonCamera.layer.borderColor = UIColor(hex: 0xc9d4e2).cgColor
        buttonCamera.layer.borderWidth = 1.5
        buttonCamera.layer.cornerRadius = 44
        buttonCamera.tintColor = UIColor(hex: 0xc9d4e2)
        buttonCamera.addTarget(self, action: #selector(actionButtonCamera), for: .touchUpInside)

        view.addSubview(buttonCamera)
        
        let configDismiss = UIImage.SymbolConfiguration(
            pointSize: 25, weight: .medium, scale: .default)
        let imageDismiss = UIImage(systemName: "pause.fill", withConfiguration: configDismiss)
        buttonDismiss.setImage(imageDismiss, for: .normal)
        buttonDismiss.layer.borderColor = UIColor.mainColor.cgColor
        buttonDismiss.layer.borderWidth = 1
        buttonDismiss.layer.cornerRadius = 29
        buttonDismiss.tintColor = .mainColor
        buttonDismiss.addTarget(self, action: #selector(actionButtonDismiss), for: .touchUpInside)

        view.addSubview(buttonDismiss)
        buttonCamera.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).multipliedBy(0.9)
            make.height.width.equalTo(88)
        }
        
        buttonDismiss.snp.makeConstraints { make in
            make.width.height.equalTo(58)
            make.leading.equalTo(view.snp.trailing).multipliedBy(0.15)
            make.centerY.equalTo(buttonCamera.snp.centerY)
        }
    }
    @objc func actionButtonDismiss() {
        self.presentAlert(title: "주의", message: "조금만 더 오르시면 산타와 함께 정복할 수 있습니다!\n정말로 그만하시겠습니까?", isCancelActionIncluded: true, preferredStyle: .alert) { action in
            let nextVC = BaseTabbarController()
            nextVC.index = 0
            self.changeRootViewController(nextVC)
        }
        
    }
    @objc func actionButtonCamera() {
        if self.mountainNowAltitude > Int(self.mountainTopAltitude * 0 / 5) {
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
        }
        else {
            self.viewExplainCamera.alpha = 1
        }
        
    }
    // MARK: 판업창
    let viewExplainCamera = UIView()
    let labelExplainCamera = UILabel()
    let imageViewExplainFlag = UIImageView()
    let buttonCloser = UIButton()
    
    func setViewExplainCamera() {
        viewExplainCamera.backgroundColor = .mainColor
        viewExplainCamera.layer.cornerRadius = 14
        viewExplainCamera.alpha = 0
        view.addSubview(viewExplainCamera)
        viewExplainCamera.snp.makeConstraints { make in
            make.bottom.equalTo(labelHiking.snp.top)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(66)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
        }
        labelExplainCamera.text = "깃발이 표시된 고도에 도착 시에만\n정상 인증이 가능합니다."
        labelExplainCamera.numberOfLines = 2
        labelExplainCamera.textColor = .white
        labelExplainCamera.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 14)
        labelExplainCamera.addCharacterSpacing(kernValue: -0.28)
        viewExplainCamera.addSubview(labelExplainCamera)
        labelExplainCamera.snp.makeConstraints { make in
            make.centerX.equalTo(viewExplainCamera)
            make.width.equalTo(180)
            make.centerY.equalTo(viewExplainCamera)
        }
        imageViewExplainFlag.image = UIImage(named: "FlagIcon@3x")
        viewExplainCamera.addSubview(imageViewExplainFlag)
        imageViewExplainFlag.snp.makeConstraints { make in
            make.height.equalTo(26.6)
            make.width.equalTo(25.1)
            make.trailing.equalTo(labelExplainCamera.snp.leading).offset(-19.1)
            make.centerY.equalTo(viewExplainCamera.snp.centerY)
        }
        
        buttonCloser.setImage(UIImage(systemName: "xmark"), for: .normal)
        buttonCloser.addTarget(self, action: #selector(actionButtonCloseExplain), for: .touchUpInside)
        buttonCloser.tintColor = .white
        viewExplainCamera.addSubview(buttonCloser)
        
        buttonCloser.snp.makeConstraints { make in
            make.width.height.equalTo(27)
            make.trailing.equalTo(viewExplainCamera).offset(-5)
            make.top.equalTo(viewExplainCamera).offset(5)
        }
    }
    @objc func actionButtonCloseExplain() {
        viewExplainCamera.alpha = 0
    }
}


extension EndViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var inputImage : Data?
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            inputImage = image.jpegData(compressionQuality: 0.1)
        }
        dismiss(animated: true) {
            self.presentAlert(title: "해당 사진으로 진행할까요?", message: "해당 산과 무관한 사진을 올릴 시\n제재가 가해질 수 있습니다.", isCancelActionIncluded: true, preferredStyle: .alert) { action in
                if let idx = self.mountainIdx {
                    EndViewControllerDataManager().appflagsmountainIdx(self, idx, inputImage!, self.nowLatitude, self.nowLogitude, Double(self.mountainNowAltitude) )
                }
                
            }
        }
    }
}

extension EndViewController {
    func successDataImageRegister() {
        let nextVC = ConquerViewController()
        if let idx = self.mountainIdx {
            nextVC.mountainIdx = idx
        }
        nextVC.modalPresentationStyle = .overFullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        present(nextVC, animated: true, completion: nil)
    }
    func failureDataImageRegister(_ message: String) {
        self.presentAlert(title: message)
    }
}

extension EndViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            labelNowAltitude.text = String(format: "%.0f", location.altitude)
            mountainNowAltitude = Int(location.altitude)
            nowLatitude = location.coordinate.latitude
            nowLogitude = location.coordinate.longitude
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
