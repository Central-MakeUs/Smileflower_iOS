//
//  HomeViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/12/22.
//

import UIKit
import Kingfisher

class HomeViewController: BaseViewController {

    let viewModel = HomeViewModel()
    let viewModelLike = FeedLikdeViewModel()
    var arrayPicture : [HomeModelPictureList] = []
    var arrayUser : [HomeModelUserList] = []
    var arrayMountain : [HomeModelMountainsList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Constant.JWTToken)
        print(Constant.userIdx)
        navigationBarSet()
        setScrollView()
        setTopContentView()
        setConquerImageView()
        setAccumulateAltitudeView()
        setCompeteView()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.post(name: Notification.Name("middleButtonAppear"), object: nil)
        viewModel.appNewHomeAPI { noti ,resultPicture, resultUser, resultMounatain in
            self.arrayPicture = resultPicture
            self.arrayUser = resultUser
            self.arrayMountain = resultMounatain
            if noti == "f" {
                self.rightButton.image = UIImage(named: "icHomeNotificationNormal")
                self.rightButton.tintColor = .bluegray
            } else {
                self.rightButton.image = UIImage(named: "icHomeNotificationFocused")
                self.rightButton.tintColor = .mainColor
            }
            self.collectionViewConquerImage.reloadData()
            self.collectionViewTopTen.reloadData()
            self.collectionViewCompete.reloadData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    override func viewDidLayoutSubviews() {
    }
    // MARK: 네비게이션 바
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "icHomeNotificationNormal"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .bluegray
        return button
        
    }()
    func navigationBarSet() {
        let height: CGFloat = 75
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.clear
        navbar.delegate = self

        let navItem = UINavigationItem()
        navItem.rightBarButtonItem = self.rightButton
        navbar.items = [navItem]
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.layoutIfNeeded()
        view.addSubview(navbar)
    }
    @objc func actionBackButton(_ sender : Any) {
        let nextVC = HomeAlertViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //MARK: 스크롤뷰 구현
    let scrollViewContent : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    let viewContent = UIView()

    func setScrollView() {
        scrollViewContent.delegate = self
        view.addSubview(scrollViewContent)
        scrollViewContent.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(view).offset(75)
        }
        scrollViewContent.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.edges.equalTo(scrollViewContent)
            make.height.equalTo(10000)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }
    
    //MARK: 상단 컨탠트 구성
    let imageViewHuman : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "illustHomeMan")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // "SANTA" 라벨
    let labelSanta : UILabel = {
        let label = UILabel()
        label.text = "SANTA"
        label.font = UIFont(name: Constant.fontWowFont, size: 21)
        label.setTextWithLineHeight(text: label.text, lineHeight: 28)
        label.addCharacterSpacing(kernValue: -1.05)
        label.textColor = .mainColor
        return label
    }()
    // "함께" 라벨
    let labelWith : UILabel = {
        let label = UILabel()
        label.text = "함께"
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 18)
        label.setTextWithLineHeight(text: label.text, lineHeight: 24)
        label.textColor = .darkbluegray
        label.alpha = 0.87
        return label
    }()
    // "등산을 시작해보세요" 라벨
    let labelGoMountain : UILabel = {
        let label = UILabel()
        label.text = "등산을 시작해보세요:)"
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 18)
        label.setTextWithLineHeight(text: label.text, lineHeight: 24)
        label.textColor = .darkbluegray
        label.alpha = 0.87
        return label
    }()
    // 산타에 등록된 산 검색하기 버튼
    let buttonSearchMountain : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 22
        button.layer.borderColor = UIColor.mainColor.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .iceblue
        button.addTarget(self, action: #selector(actionGoSearchMountain), for: .touchUpInside)
        
        let label = UILabel()
        label.text = "산타에 등록된 산 검색하기"
        label.textColor = .bluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 15)
        label.setTextWithLineHeight(text: label.text, lineHeight: 19)
        button.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(button)
            make.leading.equalTo(button).offset(19)
        }
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icHomeSearch")
        imageView.contentMode = .scaleAspectFit
        button.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(button)
            make.trailing.equalTo(button).offset(-16.8)
            make.width.height.equalTo(25.2)
        }
        return button
    }()
    @objc func actionGoSearchMountain() {
        let nextVC = SearchViewController()
        nextVC.modalPresentationStyle = .fullScreen
        tabBarController?.tabBar.isHidden = true
        NotificationCenter.default.post(name: Notification.Name("middleButtonHidden"), object: nil)
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    // 뷰의 상단 구성
    func setTopContentView() {
        viewContent.addSubview(imageViewHuman)
        imageViewHuman.snp.makeConstraints { make in
            make.top.equalTo(viewContent).offset(19.6)
            make.leading.equalTo(view).offset(21)
            make.width.equalTo(97.9)
            make.height.equalTo(85.4)
        }
        viewContent.addSubview(labelSanta)
        labelSanta.snp.makeConstraints { make in
            make.top.equalTo(viewContent).offset(43)
            make.leading.equalTo(viewContent).offset(115)
        }
        viewContent.addSubview(labelWith)
        labelWith.snp.makeConstraints { make in
            make.centerY.equalTo(labelSanta)
            make.leading.equalTo(labelSanta.snp.trailing).offset(4)
        }
        
        viewContent.addSubview(labelGoMountain)
        labelGoMountain.snp.makeConstraints { make in
            make.leading.equalTo(labelSanta)
            make.top.equalTo(labelSanta.snp.bottom)
        }
        
        viewContent.addSubview(buttonSearchMountain)
        buttonSearchMountain.snp.makeConstraints { make in
            make.top.equalTo(imageViewHuman.snp.bottom).offset(-1)
            make.centerX.equalTo(viewContent)
            make.width.equalTo(342)
            make.height.equalTo(44)
        }
    }
    //MARK: 정복 인증샷 CollectionView
    // "정복 인증샷" 라벨
    let labelConquerImage : UILabel = {
        let label = UILabel()
        label.text = "정복 인증샷"
        label.textColor = .darkbluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 20)
        label.setTextWithLineHeight(text: label.text, lineHeight: 24)
        label.addCharacterSpacing(kernValue: -0.6)
        return label
    }()
    // 더보기 버튼
    let buttonMoreConquerImage : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(goMoreCoquerView), for: .touchUpInside)
        let label = UILabel()
        label.text = "더 보기"
        label.textColor = .bluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 13)
        label.setTextWithLineHeight(text: label.text, lineHeight: 16)
        label.addCharacterSpacing(kernValue: -0.39)
        
        button.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(button)
            make.centerY.equalTo(button)
        }
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icHomeArrowRight")
        imageView.contentMode = .scaleAspectFit
        
        button.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.trailing.equalTo(button)
            make.centerY.equalTo(label)
            make.width.height.equalTo(24)
        }
        return button
    }()
    @objc func goMoreCoquerView() {
        let NextVC = DetailConquerViewController()
        
        self.navigationController?.pushViewController(NextVC, animated: true)
    }
    // 정복 인증샷 collectionView
    let collectionViewConquerImage: UICollectionView = {
            
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setConquerImageView() {
        viewContent.addSubview(labelConquerImage)
        labelConquerImage.snp.makeConstraints { make in
            make.top.equalTo(buttonSearchMountain.snp.bottom).offset(31)
            make.leading.equalTo(viewContent).offset(21)
        }
        
        viewContent.addSubview(buttonMoreConquerImage)
        buttonMoreConquerImage.snp.makeConstraints { make in
            make.trailing.equalTo(-12)
            make.centerY.equalTo(labelConquerImage)
            make.width.equalTo(57)
            make.height.equalTo(25)
        }
        
        collectionViewConquerImage.delegate = self
        collectionViewConquerImage.dataSource = self
        collectionViewConquerImage.register(ConquerImageCollectionViewCell.self, forCellWithReuseIdentifier: ConquerImageCollectionViewCell.resueidentifier)
        viewContent.addSubview(collectionViewConquerImage)
        collectionViewConquerImage.snp.makeConstraints { make in
            make.top.equalTo(labelConquerImage.snp.bottom).offset(16)
            make.leading.trailing.equalTo(viewContent)
            make.height.equalTo(212)
        }
    }
    
    //MARK: 누적 고도 CollectionView
    // "누적 고도" 라벨
    let labelAccumulateAltitude : UILabel = {
        let label = UILabel()
        label.text = "누적 고도"
        label.textColor = .darkbluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 20)
        label.setTextWithLineHeight(text: label.text, lineHeight: 24)
        label.addCharacterSpacing(kernValue: -0.6)
        return label
    }()
    // "TOP 10" 이미지
    let imageViewTopTen : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "illustHomeTop10")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // TOP 10 뷰
    let collectionViewTopTen: UICollectionView = {
            
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = (UIScreen.main.bounds.width - 333)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: ((UIScreen.main.bounds.width - 333) / 2), bottom: 0, right: ((UIScreen.main.bounds.width - 333) / 2))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    func setAccumulateAltitudeView() {
        viewContent.addSubview(labelAccumulateAltitude)
        labelAccumulateAltitude.snp.makeConstraints { make in
            make.top.equalTo(collectionViewConquerImage.snp.bottom).offset(37)
            make.leading.equalTo(viewContent).offset(21)
        }
        viewContent.addSubview(imageViewTopTen)
        imageViewTopTen.snp.makeConstraints { make in
            make.leading.equalTo(labelAccumulateAltitude.snp.trailing).offset(2)
            make.centerY.equalTo(labelAccumulateAltitude)
            make.width.equalTo(73)
            make.height.equalTo(25)
        }
        collectionViewTopTen.delegate = self
        collectionViewTopTen.dataSource = self
        collectionViewTopTen.register(AltitudeRankingCollectionViewCell.self, forCellWithReuseIdentifier: AltitudeRankingCollectionViewCell.resueidentifier)
        viewContent.addSubview(collectionViewTopTen)
        collectionViewTopTen.snp.makeConstraints { make in
            make.top.equalTo(labelAccumulateAltitude.snp.bottom).offset(14)
            make.leading.trailing.equalTo(viewContent)
            make.height.equalTo(327)
        }
    }
    
    // MARK: 경쟁중 CollectionView
    // "경쟁 중" 라벨
    let labelGocompete : UILabel = {
        let label = UILabel()
        label.text = "경쟁 중"
        label.textColor = .darkbluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 20)
        label.setTextWithLineHeight(text: label.text, lineHeight: 24)
        label.addCharacterSpacing(kernValue: -0.6)
        return label
    }()
    let labelGoCompeteExplain : UILabel = {
        let label = UILabel()
        label.text = "경쟁중인 맵에서 랭커가 되어보세요!"
        label.textColor = .lightbluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoRegular, size: 15)
        return label
    }()
    // 정복 인증샷 collectionView
    let collectionViewCompete : UICollectionView = {
            
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15.1
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 21, bottom: 10, right: 21)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    // 경쟁중인 뷰 구성
    func setCompeteView() {
        viewContent.addSubview(labelGocompete)
        labelGocompete.snp.makeConstraints { make in
            make.leading.equalTo(viewContent).offset(26)
            make.top.equalTo(collectionViewTopTen.snp.bottom).offset(38)
        }
        
        viewContent.addSubview(labelGoCompeteExplain)
        labelGoCompeteExplain.snp.makeConstraints { make in
            make.bottom.equalTo(labelGocompete)
            make.leading.equalTo(labelGocompete.snp.trailing).offset(2)
        }
        
        collectionViewCompete.delegate = self
        collectionViewCompete.dataSource = self
        collectionViewCompete.register(CompeteCollectionViewCell.self, forCellWithReuseIdentifier: CompeteCollectionViewCell.resueidentifier)
        viewContent.addSubview(collectionViewCompete)
        collectionViewCompete.snp.makeConstraints { make in
            make.top.equalTo(labelGocompete.snp.bottom).offset(13.5)
            make.leading.trailing.equalTo(viewContent)
            make.height.equalTo(353.2)
        }
    }
}

extension HomeViewController : UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewTopTen {
            return 2
        } else if collectionView == collectionViewCompete{
            return arrayMountain.count
        } else {
            return arrayPicture.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewTopTen {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AltitudeRankingCollectionViewCell.resueidentifier, for: indexPath) as? AltitudeRankingCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.arrayUser = arrayUser
            cell.tableViewContent.reloadData()
            cell.layer.borderColor = UIColor.lightbluegray.cgColor
            cell.layer.borderWidth = 1.5
            cell.layer.cornerRadius = 20
            cell.cellIndex = indexPath.row
            return cell
        } else if collectionView == collectionViewCompete {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompeteCollectionViewCell.resueidentifier, for: indexPath) as? CompeteCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.backgroundColor = .white
            cell.layer.cornerRadius = 20
            cell.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.layer.shadowColor = UIColor.paleblue.cgColor
            cell.layer.shadowRadius = 7
            cell.layer.shadowOpacity = 0.97
            
            if arrayMountain[indexPath.row].isHot == "t" {
                cell.imageViewisPopular.image = UIImage(named: "icHomeCompeteilke")
            }
            
            if let urlString = arrayMountain[indexPath.row].mountainImageUrl {
                let url = URL(string: urlString)
                cell.imageViewMountain.kf.indicatorType = .activity
                cell.imageViewMountain.kf.setImage(with: url)
            }
            
            if let urlString = arrayMountain[indexPath.row].userImageUrl {
                let url = URL(string: urlString)
                cell.imageViewProfile.kf.indicatorType = .activity
                let proceesor = DownsamplingImageProcessor(size: cell.imageViewProfile.bounds.size)
                cell.imageViewProfile.kf.setImage(with: url, options: [.processor(proceesor)])
            }
            
            cell.labelMountainName.text = arrayMountain[indexPath.row].mountainName
            cell.labelMountainHeight.text = "\(arrayMountain[indexPath.row].intTypeHigh ?? 0)m"
            
            switch arrayMountain[indexPath.row].difficulty {
            case 1:
                cell.imageViewDifficult.image = UIImage(named: "illustHome1")
            case 2:
                cell.imageViewDifficult.image = UIImage(named: "illustHome2")
            case 3:
                cell.imageViewDifficult.image = UIImage(named: "illustHome3")
            case 4:
                cell.imageViewDifficult.image = UIImage(named: "illustHome4")
            default:
                cell.imageViewDifficult.image = UIImage(named: "illustHome5")
            }
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConquerImageCollectionViewCell.resueidentifier, for: indexPath) as? ConquerImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.labelUserLv.text = arrayPicture[indexPath.row].level
            cell.labelUserNickName.text = arrayPicture[indexPath.row].userName
            cell.labelPostLikeNumber.text = "\(arrayPicture[indexPath.row].saveCount ?? 0)"
            cell.labelPostMessageNumber.text = "\(arrayPicture[indexPath.row].commentCount ?? 0)"
            if let urlString = arrayPicture[indexPath.row].userImageUrl {
                let url = URL(string: urlString)
                cell.imageViewUserProfile.kf.indicatorType = .activity
                let proceesor = DownsamplingImageProcessor(size: cell.imageViewUserProfile.bounds.size)
                cell.imageViewUserProfile.kf.setImage(with: url, options: [.processor(proceesor)])
            } else {
                cell.imageViewUserProfile.image = UIImage(named: "personhome")
            }
            if let urlString = arrayPicture[indexPath.row].flagImageUrl {
                let url = URL(string: urlString)
                cell.imageViewUserConquer.kf.indicatorType = .activity
                cell.imageViewUserConquer.kf.setImage(with: url)
            }
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.borderColor = UIColor.lightbluegray.cgColor
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewTopTen {
            return CGSize(width: 333, height: 327)
        } else if collectionView == collectionViewCompete {
            return CGSize(width: UIScreen.main.bounds.width - 42, height: 91)
        } else {
            return CGSize(width: 233, height: 212)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewCompete {
            if let idx = arrayMountain[indexPath.row].mountainIdx, let mountainName = arrayMountain[indexPath.row].mountainName, let high = arrayMountain[indexPath.row].intTypeHigh {
                let nextVC = RankingMountainViewController(contentRankingViewController: ContentRankViewController(), contentMountainViewController: ContentMountainViewController())
                nextVC.mountainIndex = idx
                nextVC.mountainName = mountainName
                nextVC.mountainHeight = high
                nextVC.modalPresentationStyle = .fullScreen
                nextVC.modalTransitionStyle = .crossDissolve
                self.present(nextVC, animated: true, completion: nil)
            }
        } else if collectionView === collectionViewConquerImage {
            let NextVC = DetailMessageViewController()
            NextVC.flagIndex = arrayPicture[indexPath.row].flagIdx ?? 0
            NextVC.previousView = "Home"
            self.tabBarController?.tabBar.isHidden = true
            NotificationCenter.default.post(name: Notification.Name("middleButtonHidden"), object: nil)
            self.navigationController?.pushViewController(NextVC, animated: true)
        }
    }
}
