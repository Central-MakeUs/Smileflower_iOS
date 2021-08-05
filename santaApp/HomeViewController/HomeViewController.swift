//
//  HomeViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import UIKit
import SnapKit
import Kingfisher

class HomeViewController : BaseViewController, UINavigationBarDelegate {
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
    // MAKR: 네비게이션 바 커스텀
//    lazy var rightButton: UIBarButtonItem = {
//        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(actionGoExplain))
//        button.tag = 2
//        button.tintColor = .titleColorGray
//        return button
//
//    }()
    let imageViewSantaLogo = UIImageView()
    //MARK: 네비게이션 바 로고 설정
    func navigationBarSetLogo() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    func setNavigationBar() {
        let height: CGFloat = 30
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.clear
        navbar.delegate = self

        imageViewSantaLogo.image = UIImage(named: "1083@3x")
        imageViewSantaLogo.frame = CGRect(x: 0, y: 0, width: 48.1, height: 22.5)
        let navItem = UINavigationItem()
//        navItem.rightBarButtonItem = self.rightButton
        navbar.items = [navItem]
        navbar.topItem?.titleView = imageViewSantaLogo
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.layoutIfNeeded()
        view.addSubview(navbar)
    }
//    @objc func actionGoExplain() {
//        let ShowVC = FlagExplainViewController()
//        ShowVC.modalPresentationStyle = .overFullScreen
//        self.present(ShowVC, animated: false, completion: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeViewDataManager().apphomes(viewcontroller: self)
        print(Constant.JWTToken)
        print(Constant.userIdx)
        setScrollView()
        navigationBarSetLogo()
        setNavigationBar()

        imageViewSetBackground()
        LabelSetHikeWithSANTA()
        searchButtonSet()
        labelSetConquer()
        collectionViewSetConquer()
        setImageViewHuman()
        viewSetProfile()
    }
    override func viewWillAppear(_ animated: Bool) {
        HomeViewDataManager().apphomes(viewcontroller: self)
    }

    override func viewWillLayoutSubviews() {
        labelConquer.text = homeStatus
        mask.frame = imageViewUserProfile.bounds
        carouselCollectionView.reloadData()
    }
    let scrollView = UIScrollView()
    let viewContent = UIView()
    func setScrollView() {
        scrollView.indicatorStyle = .default
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        scrollView.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.edges.equalTo(view)
            make.width.equalTo(UIScreen.main.bounds.width)
//            make.height.equalTo(812)
        }
    }
    
    //MARK: 배경 설정
    func imageViewSetBackground() {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "Homebackground@3x")
        imageView.contentMode = .top
        self.viewContent.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(viewContent.snp.top).offset(70)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(viewContent.snp.bottom)
        }
    }
   
    //MARK: 프로필 사진 설정
    let imageViewUserProfile = UIImageView()
    let mask = UIImageView()
    func viewSetProfile() {
        viewProfile.backgroundColor = .none
        viewContent.addSubview(viewProfile)
        viewProfile.snp.makeConstraints { make in
            make.width.equalTo(92)
            make.height.equalTo(115)
            make.bottom.equalTo(labelHikeWithSANTA.snp.top)
            make.leading.equalTo(viewContent.snp.leading).offset(35)
        }
        
        let imageViewProfile = UIImageView()
        imageViewProfile.image = UIImage(named: "profileView@3x")
        imageViewProfile.contentMode = .scaleAspectFill
        viewProfile.addSubview(imageViewProfile)

        imageViewProfile.snp.makeConstraints { make in
            make.edges.equalTo(viewProfile.snp.edges)
        }
        if let stringURL = userImage {
            let url = URL(string: stringURL)
            imageViewUserProfile.kf.indicatorType = .activity
            imageViewUserProfile.kf.setImage(with: url)
        }
        else {
            imageViewUserProfile.image = UIImage(named: "personhome@3x")
        }
        imageViewUserProfile.tintColor = .titleColorGray
        imageViewUserProfile.contentMode = .scaleAspectFill
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
        viewContent.addSubview(labelHikeWithSANTA)
        
        labelHikeWithSANTA.snp.makeConstraints { make in
            make.leading.equalTo(viewContent.snp.leading).offset(34)
            make.top.equalTo(viewContent.snp.top).offset(233)
        }
        labelHikeWithSANTA.layer.zPosition = 499
    }
    //MARK: 어디로 갈까요?
    func searchButtonSet() {
        searchButton.backgroundColor = .mainColor
        searchButton.layer.cornerRadius = 25
        searchButton.layer.shadowColor = UIColor(hex: 0x1f8d83).cgColor
        searchButton.layer.shadowRadius = 9
        searchButton.layer.shadowOffset = CGSize(width: 2, height: 4)
        searchButton.layer.shadowOpacity = 0.3
        searchButton.addTarget(self, action: #selector(actionGoSearchView), for: .touchUpInside)
        
        viewContent.addSubview(searchButton)
        
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
    //MARK: 배경 사람 마크
    let imageViewHuman = UIImageView()
    func setImageViewHuman() {
        imageViewHuman.contentMode = .scaleAspectFit
        imageViewHuman.image = UIImage(named: "illustHomeMan@3x")
        viewContent.addSubview(imageViewHuman)
        imageViewHuman.snp.makeConstraints { make in
            make.bottom.equalTo(searchButton.snp.top).offset(2)
            make.trailing.equalTo(searchButton.snp.trailing).offset(-14.7)
            make.width.equalTo(122.5)
            make.height.equalTo(143.4)
        }
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
        viewContent.addSubview(labelConquer)
        
        labelConquer.snp.makeConstraints { make in
            make.leading.equalTo(viewContent.snp.leading).offset(34)
            make.top.equalTo(searchButton.snp.bottom).offset(44)
        }
    }
    //MARK: Carousel Collection View
    func collectionViewSetConquer() {
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        carouselCollectionView.register(ConquerCollectionViewCell.self, forCellWithReuseIdentifier: ConquerCollectionViewCell.identifier)
        
        viewContent.addSubview(carouselCollectionView)
        
        carouselCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(viewContent.snp.leading)
            make.trailing.equalTo(viewContent.snp.trailing)
            make.top.equalTo(labelConquer.snp.bottom).offset(15)
            make.height.equalTo(251)
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
            cell.layer.shadowColor = UIColor(hex: 0x35507c).cgColor
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
                    cell.imageViewMountain.kf.indicatorType = .activity
                    cell.imageViewMountain.kf.setImage(with: url, options: [.processor(proceesor)])
                }
                if let stringUrl = mountainCell[indexPath.row].userImage {
                    let url = URL(string: stringUrl)
                    let proceesor = DownsamplingImageProcessor(size: cell.imageProfile.bounds.size)
                    cell.imageProfile.kf.indicatorType = .activity
                    cell.imageProfile.kf.setImage(with: url, options: [.processor(proceesor)])
                }
                else {
                    cell.imageProfile.image = UIImage(named: "personhome@3x")
                }
                
               
                switch mountainCell[indexPath.row].difficulty {
                    case 1:
                        cell.imageViewDifficulty.image = UIImage(named: "illustHome1@3x")
                    case 2:
                        cell.imageViewDifficulty.image = UIImage(named: "illustHome2@3x")
                case 3:
                    cell.imageViewDifficulty.image = UIImage(named: "illustHome3@3x")
                    case 4:
                        cell.imageViewDifficulty.image = UIImage(named: "illustHome4@3x")
                    case 5:
                        cell.imageViewDifficulty.image = UIImage(named: "illustHome5@3x")
                    default :
                        print("오류")
                }
            }
            cell.imagemask.frame = cell.imageProfile.bounds
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 177, height: 221)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if let mountainCell = mountain {
            let nextVC = RankingMountainViewController(contentRankingViewController: ContentRankViewController(), contentMountainViewController: ContentMountainViewController())
            nextVC.mountainIndex = mountainCell[indexPath.row].mountainIdx
            nextVC.mountainName = mountainCell[indexPath.row].mountainName!
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
        if let stringURL = userImage {
            let url = URL(string: stringURL)
            imageViewUserProfile.kf.indicatorType = .activity
            imageViewUserProfile.kf.setImage(with: url)
        }
        else {
            imageViewUserProfile.image = UIImage(named: "personhome@3x")
        }
    }
    func failureDataReceive(_ message : String) {
        self.presentAlert(title: message)
    }
}

