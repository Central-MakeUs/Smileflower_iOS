//
//  EndViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/02.
//

import UIKit
import MobileCoreServices
import Lottie
import MTSlideToOpen
import CoreLocation

class EndViewController : BaseViewController, UINavigationBarDelegate {
    let picker = UIImagePickerController()
    var flagImageSave = false
    var mountainIdx : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserPosition()
        view.setDirectionGradient(color1: UIColor(hex: 0x9AC7FF), color2: UIColor(hex:0x24C7B9))
        picker.delegate = self
        navigationBarSet()
        setAnimation()
        setLabelHiking()
        buttonSetEnd()
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
            print(locationManager.location?.coordinate)
        } else {
            print("위치 서비스 off 상태")
        }
    }
    // MARK: 네비게이션 바
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .white
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
        animationView.backgroundColor = .clear
        view.addSubview(animationView)
        animationView.frame = CGRect(x: UIScreen.main.bounds.width/2 - 55, y: UIScreen.main.bounds.height/2 - 108, width: 110, height: 216)
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
        labelHiking.textColor = .white
        view.addSubview(labelHiking)
        labelHiking.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.centerY).offset(-156)
            make.centerX.equalTo(view.snp.centerX)
        }
        labelMountain.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 27)
        labelMountain.textColor = .white
        view.addSubview(labelMountain)
        labelMountain.snp.makeConstraints { make in
            make.bottom.equalTo(labelHiking.snp.top).offset(-5.6)
            make.centerX.equalTo(labelHiking.snp.centerX).offset(10)
        }
        imageViewPosition.image = UIImage(named: "icHikingMap@3x")
        imageViewPosition.contentMode = .scaleAspectFit
        view.addSubview(imageViewPosition)
        imageViewPosition.snp.makeConstraints { make in
            make.trailing.equalTo(labelMountain.snp.leading).offset(-6.6)
            make.centerY.equalTo(labelMountain)
            make.width.equalTo(22.9)
            make.height.equalTo(27.7)
        }
    }
    // MARK: 도착버튼
    var Hikinglabel: UILabel = {
            let label = PaddingLabel(withInsets: 0, 0, 40 , 0)
            label.text = "밀어서 인증사진 찍기"
            label.textColor = UIColor(hex: 0xffffff, alpha: 0.5)
            label.textAlignment = .center
            label.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 18)
            return label
        }()
    
    func buttonSetEnd() {
        let width = UIScreen.main.bounds.width * 0.8
        let slide = MTSlideToOpenView(frame: CGRect(x: UIScreen.main.bounds.width/2 - width/2, y: 596, width: UIScreen.main.bounds.width * 0.8, height: 80))
        slide.sliderViewTopDistance = 6
        slide.sliderHolderView.backgroundColor = UIColor(hex: 0x1c3240, alpha: 0.1)
        slide.sliderCornerRadius = 35
        slide.delegate = self
        slide.textLabel.addSubview(Hikinglabel)
        Hikinglabel.snp.makeConstraints { make in
            make.edges.equalTo(slide.textLabel)
        }
        slide.textLabel.text = ""
        slide.thumnailImageView.image = UIImage(named: "icHikingCamera@3x")
        slide.thumnailImageView.backgroundColor = .white
        slide.slidingColor = UIColor(hex: 0xffffff , alpha: 0.4)
        view.addSubview(slide)
    }
func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
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
                    EndViewControllerDataManager().appflagsmountainIdx(self, idx, inputImage!)
                }
                
            }
        }
    }
}
extension EndViewController : MTSlideToOpenDelegate {
    func mtSlideToOpenDelegateDidFinish(_ sender: MTSlideToOpenView) {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
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
        self.present(nextVC, animated: true, completion: nil)
    }
    func failureDataImageRegister(_ message: String) {
        self.presentAlert(title: message)
    }
}

extension EndViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.first {
            print("위도 : \(location.coordinate.latitude)")
            print("경도 : \(location.coordinate.longitude)")
            print("고도 : \(location.altitude)")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
