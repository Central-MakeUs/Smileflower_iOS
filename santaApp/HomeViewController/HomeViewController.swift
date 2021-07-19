//
//  HomeViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Kingfisher

class HomeViewController : BaseViewController {
    let labelHikeWithSANTA = UILabel()
    let labelConquer = UILabel()
    let searchButton = UIButton()
    let viewProfile = UIView(frame: CGRect(x: 35, y: 126, width: 74, height: 97))
    
    //MARK: 가져올 데이터 변수들
    var userIdx : Int?
    var userImage : String?
    var homeStatus : String? = ""
    var mountain : [DataMyFlagMountain]?
    
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
    
    //MARK: 인디케이털
//    let indicator = NVActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.width/2 - 35, y: UIScreen.main.bounds.height/2 - 35, width: 70, height: 70), type: .ballScale, color: .mainColor, padding: 10)
//    let indicatorView = UIView()
//
//    func setindicator() {
//        indicatorView.backgroundColor = .black
//        indicatorView.alpha = 0.7
//        self.view.addSubview(indicatorView)
//        indicatorView.snp.makeConstraints { make in
//            make.edges.equalTo(view)
//        }
//        indicatorView.layer.zPosition = 99
//        self.view.addSubview(self.indicator)
//        indicator.layer.zPosition = 999
//        indicator.startAnimating()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Constant.JWTToken)
//        setindicator()
        navigationBarSetLogo()
        imageViewSetBackground()
        LabelSetHikeWithSANTA()
        viewSetProfile()
        searchButtonSet()
        labelSetConquer()
        collectionViewSetConquer()
        HomeViewDataManager().apphomes(viewcontroller: self)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.indicator.stopAnimating()
//            self.indicatorView.removeFromSuperview()
//        }
    }

    override func viewWillLayoutSubviews() {
        labelConquer.text = homeStatus
        mask.frame = imageViewUserProfile.bounds
        carouselCollectionView.reloadData()
        if let stringURL = userImage {
            let url = URL(string: stringURL)
            let proccess = DownsamplingImageProcessor(size: imageViewUserProfile.bounds.size)
            imageViewUserProfile.kf.setImage(with: url , options: [.processor(proccess)])
        }
    }
    //MARK: 네비게이션 바 로고 설정
    func navigationBarSetLogo() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 48.1, height: 48.1))
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
    let imageViewUserProfile = UIImageView()
    let mask = UIImageView()
    func viewSetProfile() {
        viewProfile.backgroundColor = .none
        view.addSubview(viewProfile)
        viewProfile.snp.makeConstraints { make in
            make.width.equalTo(92)
            make.height.equalTo(115)
            make.bottom.equalTo(labelHikeWithSANTA.snp.top)
            make.leading.equalTo(view.snp.leading).offset(35)
        }
        
        let imageViewProfile = UIImageView()
        imageViewProfile.image = UIImage(named: "profileView@3x")
        imageViewProfile.contentMode = .scaleAspectFill
        viewProfile.addSubview(imageViewProfile)

        imageViewProfile.snp.makeConstraints { make in
            make.edges.equalTo(viewProfile.snp.edges)
        }
        imageViewUserProfile.image = UIImage(named: "personhome@3x")
        imageViewUserProfile.tintColor = .titleColorGray
        imageViewUserProfile.contentMode = .scaleAspectFit
        viewProfile.addSubview(imageViewUserProfile)
        imageViewUserProfile.snp.makeConstraints { make in
            make.centerX.equalTo(viewProfile.snp.centerX).offset(-1)
            make.centerY.equalTo(viewProfile.snp.centerY).offset(-2)
            make.width.equalTo(64)
            make.height.equalTo(85)
        }
        mask.image = UIImage(named: "mask@3x")
        imageViewUserProfile.mask = mask
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
    //MARK: 어디로 갈까요?
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
        let nextVC = SearchViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: false, completion: nil)
    }
    //MARK: 내가 정복한 산
    func labelSetConquer() {
        if let mountainlabel = homeStatus
        {
            print(mountainlabel)
            labelConquer.text = mountainlabel
        }
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
        if let mountainCell = mountain{
            return mountainCell.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConquerCollectionViewCell.identifier, for: indexPath) as? ConquerCollectionViewCell {
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 20
            cell.layer.shadowColor = UIColor.titleColorGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 2, height: 6)
            cell.layer.shadowRadius = 15
            cell.layer.shadowOpacity = 0.2
            if let mountainCell = mountain{
                cell.labelMountainName.text = mountainCell[indexPath.row].mountainName
                cell.labelName.text = mountainCell[indexPath.row].userName
                cell.labelConquerNumberOfTimes.text = String(mountainCell[indexPath.row].flagCount) + "회"
                if let stringUrl = mountainCell[indexPath.row].mountainImage {
                    let url = URL(string: stringUrl)
                    let proceesor = DownsamplingImageProcessor(size: cell.imageViewMountain.bounds.size)
                    cell.imageViewMountain.kf.setImage(with: url, options: [.processor(proceesor)])
                }
                if let stringUrl = mountainCell[indexPath.row].userImage {
                    let url = URL(string: stringUrl)
                    let proceesor = DownsamplingImageProcessor(size: cell.imageProfile.bounds.size)
                    cell.imageProfile.kf.setImage(with: url, options: [.processor(proceesor)])
                }
            }
            cell.imagemask.frame = cell.imageProfile.bounds
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 168, height: 212)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if let mountainCell = mountain {
            let nextVC = RankingMountainViewController(contentRankingViewController: ContentRankViewController(), contentMountainViewController: ContentMountainViewController())
            nextVC.mountainIndex = mountainCell[indexPath.row].mountainIdx
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .crossDissolve
            self.present(nextVC, animated: true, completion: nil)
        }
        
    }
}

extension HomeViewController {
    
    func successDataReceive(_ result : DataResult) {
        userIdx = result.userIdx
        userImage = result.userImage
        homeStatus = result.homeStatus
        mountain = result.myflag?.mountain
        self.carouselCollectionView.reloadData()
    }
    func failureDataReceive(_ message : String) {
        self.presentAlert(title: message)
    }
}

