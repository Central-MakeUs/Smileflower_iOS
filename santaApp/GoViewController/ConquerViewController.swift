//
//  ConquerViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/07.
//

import UIKit

class ConquerViewController: BaseViewController {

    var mountainIdx : Int?
    
    let viewContent = UIView()
    private let dimmedView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.darkGray
        view.alpha = 0.7
            return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        viewSetContent()
        imageViewSetConquer()
        labelSetWOW()
        labelSetExplain()
        buttonSetGoConquer()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        imageViewSetAniamation()
    }
    
    func viewSetContent() {
        viewContent.layer.cornerRadius = 25
        viewContent.backgroundColor = .white
        view.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).offset(17.5)
            make.width.equalTo(319)
            make.height.equalTo(491)
        }
    }
    //MARK: 깃발 이미지
    let imageViewConquer = UIImageView()
    
    func imageViewSetConquer() {
        imageViewConquer.image = UIImage(named: "conquered@3x")
        viewContent.addSubview(imageViewConquer)
        imageViewConquer.snp.makeConstraints { make in
            make.width.equalTo(241)
            make.height.equalTo(295.5)
            make.top.equalTo(viewContent.snp.top).offset(27.9)
            make.centerX.equalTo(viewContent.snp.centerX)
        }
        imageViewConquer.layer.zPosition = 999
    }
    //MARK: 애니메이션 구현
    let imageViewAnimation = UIImageView()
    
    func animatedImages(for name: String) -> [UIImage] {
        var i = 0
        var images = [UIImage]()
        while let image = UIImage(named: "\(name)/\(i)") {
            if i == 0 {
                let newimage : UIImage? = image.image(alpha: 0)
                images.append(newimage!)
            }
            else {
                let newimage : UIImage? = image.image(alpha: 1)
                images.append(newimage!)
            }
            
            i += 1
        }
        return images
    }
    
    func imageViewSetAniamation() {
        
        imageViewAnimation.animationImages = animatedImages(for: "illustHikingFirecracker")
        imageViewAnimation.animationDuration = 1
        imageViewAnimation.tintColor = UIColor.red
        imageViewAnimation.animationRepeatCount = 10000
        imageViewAnimation.image = imageViewAnimation.animationImages?.first
        imageViewAnimation.startAnimating()
        imageViewAnimation.layer.zPosition = 333
        viewContent.addSubview(imageViewAnimation)
        imageViewAnimation.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(141)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(272)
            make.height.equalTo(480)
        }
    }
   
    //MARK: WOW! 구현
    let labelWOW = UILabel()
    
    func labelSetWOW() {
        labelWOW.text = "WOW!"
        labelWOW.font = UIFont(name: Constant.fontWowFont, size: 37)
        labelWOW.textColor = UIColor(hex: 0xFF766A)
        labelWOW.textAlignment = .center
        viewContent.addSubview(labelWOW)
        labelWOW.snp.makeConstraints { make in
            make.top.equalTo(imageViewConquer.snp.bottom).offset(-16.4)
            make.centerX.equalTo(viewContent.snp.centerX)
        }
    }
    //MARK: 설명 구형
    let labelExplain = UILabel()
    
    func labelSetExplain() {
        labelExplain.text = "정산까지 올라오느라 수고하셨습니다!\n그럼 이제 정복을 하러 가볼까요?"
        labelExplain.numberOfLines = 2
        labelExplain.textAlignment = .center
        labelExplain.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 15)
        labelExplain.textColor = .darkbluegray
        viewContent.addSubview(labelExplain)
        labelExplain.snp.makeConstraints { make in
            make.centerX.equalTo(viewContent.snp.centerX)
            make.top.equalTo(labelWOW.snp.bottom).offset(8.2)
        }
    }
    //MARK: 버튼 구현
    let buttonGoConquer = UIButton()
    
    func buttonSetGoConquer() {
        buttonGoConquer.layer.cornerRadius = 22
        buttonGoConquer.backgroundColor = .darkbluegray
        buttonGoConquer.setTitle("정복하기", for: .normal)
        buttonGoConquer.setImage(UIImage(named: "FlagIconSmall@3x"), for: .normal)
        buttonGoConquer.semanticContentAttribute = .forceLeftToRight
        buttonGoConquer.imageEdgeInsets = UIEdgeInsets(top: 0, left: -3.85, bottom: 0, right: 0)
        buttonGoConquer.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -3.85)
        buttonGoConquer.addTarget(self, action: #selector(actionGoCompleteViewController), for: .touchUpInside)
        viewContent.addSubview(buttonGoConquer)
        buttonGoConquer.snp.makeConstraints { make in
            make.centerX.equalTo(viewContent.snp.centerX)
            make.top.equalTo(labelExplain.snp.bottom).offset(27.8)
            make.width.equalTo(147)
            make.height.equalTo(44)
        }
    }
    @objc func actionGoCompleteViewController() {
        let nextVC = CompleteViewController()
        if let idx = mountainIdx {
            nextVC.mountainIdx = idx
        }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
}
