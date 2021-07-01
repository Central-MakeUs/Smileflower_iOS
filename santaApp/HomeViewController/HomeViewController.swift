//
//  HomeViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import UIKit
import SnapKit

class HomeViewController : BaseViewController {
    let labelHikeWithSANTA = UILabel()
    let labelConquer = UILabel()
    
    let searchBar = UISearchBar()

    let viewProfile = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationBarSetLogo()
        imageViewSetBackground()
        viewSetProfile()
        LabelSetHikeWithSANTA()
        searchBarSet()
        labelSetConquer()
    }
    //MARK: 네비게이션 바 로고 설정
    func navigationBarSetLogo() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode   = .scaleAspectFit
        let image = UIImage(named: "1083@3x")
        imageView.image = image
        navigationItem.titleView = imageView
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    //MARK: 배경 설정
    func imageViewSetBackground() {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "Homebackground@3x")
        imageView.contentMode = .top
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(70)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    //MARK : 프로필 사진 설정
    func viewSetProfile() {
        viewProfile.backgroundColor = .none
        view.addSubview(viewProfile)
        
        viewProfile.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(131.2)
            make.leading.equalTo(view.snp.leading).offset(39.9)
            make.width.equalTo(64)
            make.height.equalTo(85)
        }
        
        let imageViewProfile = UIImageView()
        imageViewProfile.image = UIImage(named: "profileView@3x")
        imageViewProfile.contentMode = .scaleAspectFill
        viewProfile.addSubview(imageViewProfile)
        
        imageViewProfile.snp.makeConstraints { make in
            make.edges.equalTo(viewProfile.snp.edges)
        }
    }
    //MARK : For a Better Hike with SANTA
    func LabelSetHikeWithSANTA() {
        labelHikeWithSANTA.text = "For a Better\nHike with SANTA"
        labelHikeWithSANTA.numberOfLines = 2
        labelHikeWithSANTA.font = UIFont(name: Constant.fontCocogoose, size: 30)
        labelHikeWithSANTA.textColor = UIColor(hex: 0x1c3240)
        view.addSubview(labelHikeWithSANTA)
        
        labelHikeWithSANTA.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(33)
            make.top.equalTo(view.snp.top).offset(233)
        }
    }
    //MARK : SearchBar
    func searchBarSet() {
        searchBar.setImage(UIImage(named: "isSearchNonW"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.placeholder = "어디로 갈까요?"
        searchBar.setPlaceholderColor(.white, searchBar)
        searchBar.barTintColor = .mainColor
        searchBar.layer.cornerRadius = 25
        searchBar.clipsToBounds = true
        searchBar.setTextFieldColor(.mainColor, searchBar)
        searchBar.tintColor = .white
        self.view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(labelHikeWithSANTA.snp.bottom).offset(2)
            make.leading.equalTo(view.snp.leading).offset(18)
            make.trailing.equalTo(view.snp.trailing).offset(-17)
            make.height.equalTo(48)
        }
    }
    //MARK : 내가 정복한 산
    func labelSetConquer() {
        labelConquer.text = "내가 정복한 산"
        labelConquer.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 22)
        
        view.addSubview(labelConquer)
        
        labelConquer.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(34)
            make.top.equalTo(searchBar.snp.bottom).offset(44)
        }
    }
    //MARK : Carousel Collection View
    
}
