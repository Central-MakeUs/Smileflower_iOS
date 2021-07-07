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
    
    let searchButton = UIButton()

    let viewProfile = UIView()
    
    let carouselCollectionView: UICollectionView = {
            
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 22
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 34, bottom: 30, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationBarSetLogo()
        imageViewSetBackground()
        viewSetProfile()
        LabelSetHikeWithSANTA()
        searchButtonSet()
        labelSetConquer()
        collectionViewSetConquer()
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
    //MARK: 프로필 사진 설정
    func viewSetProfile() {
        viewProfile.backgroundColor = .none
        view.addSubview(viewProfile)
        
        viewProfile.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(126)
            make.leading.equalTo(view.snp.leading).offset(35)
            make.width.equalTo(74)
            make.height.equalTo(97)
        }
        
        let imageViewProfile = UIImageView()
        imageViewProfile.image = UIImage(named: "profileView@3x")
        imageViewProfile.contentMode = .scaleAspectFill
        viewProfile.addSubview(imageViewProfile)
        
        imageViewProfile.snp.makeConstraints { make in
            make.edges.equalTo(viewProfile.snp.edges)
        }
    }
    //MARK: For a Better Hike with SANTA
    func LabelSetHikeWithSANTA() {
        labelHikeWithSANTA.text = "For a Better\nHike with SANTA"
        labelHikeWithSANTA.numberOfLines = 2
        labelHikeWithSANTA.font = UIFont(name: Constant.fontCocogoose, size: 30)
        labelHikeWithSANTA.textColor = UIColor(hex: 0x1c3240)
        labelHikeWithSANTA.alpha = 0.91
        labelHikeWithSANTA.setTextWithLineHeight(text: labelHikeWithSANTA.text, lineHeight: 32)
        view.addSubview(labelHikeWithSANTA)
        
        labelHikeWithSANTA.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(34)
            make.top.equalTo(view.snp.top).offset(233)
        }
    }
    //MARK: SearchBar
    func searchButtonSet() {
        searchButton.backgroundColor = .mainColor
        searchButton.layer.cornerRadius = 25
        searchButton.addTarget(self, action: #selector(actionGoSearchView), for: .touchUpInside)
        
        view.addSubview(searchButton)
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(labelHikeWithSANTA.snp.bottom).offset(12)
            make.leading.equalTo(18)
            make.trailing.equalTo(-17)
            make.height.equalTo(48)
        }
        
        let label = UILabel()
        label.text = "어디로 갈까요?"
        label.textColor = .white
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 15)
        searchButton.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(searchButton.snp.leading).offset(18)
            make.centerY.equalTo(searchButton.snp.centerY)
        }
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search@3x")
        searchButton.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.trailing.equalTo(searchButton.snp.trailing).offset(-16.8)
            make.centerY.equalTo(searchButton.snp.centerY)
        }
    }
    @objc func actionGoSearchView() {
        print("click")
    }
    //MARK: 내가 정복한 산
    func labelSetConquer() {
        labelConquer.text = "내가 정복한 산"
        labelConquer.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 22)
        labelConquer.addCharacterSpacing(kernValue: -0.66)
        view.addSubview(labelConquer)
        
        labelConquer.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(34)
            make.top.equalTo(searchButton.snp.bottom).offset(44)
        }
    }
    //MARK: Carousel Collection View
    func collectionViewSetConquer() {
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        carouselCollectionView.register(ConquerCollectionViewCell.self, forCellWithReuseIdentifier: ConquerCollectionViewCell.identifier)
        
        view.addSubview(carouselCollectionView)
        
        carouselCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(labelConquer.snp.bottom).offset(15)
            make.height.equalTo(242)
        }
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConquerCollectionViewCell.identifier, for: indexPath) as? ConquerCollectionViewCell {
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 20
            cell.layer.shadowColor = UIColor.titleColorGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 2, height: 6)
            cell.layer.shadowRadius = 15
            cell.layer.shadowOpacity = 0.2
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 168, height: 212)
    }
}


