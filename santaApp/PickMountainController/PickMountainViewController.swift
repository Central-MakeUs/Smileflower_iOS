//
//  PickMountainViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import UIKit

class PickMountainViewController : BaseViewController {
    
    var mountainPicks : [MountainPicksResult] = []
    
    let carouselCollectionViewLikeMountain: UICollectionView = {
            
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 27, left: 19, bottom: 27, right: 19)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TrackingTool.Screen(screenName: "view_like_mountain")
        navigationBarSet()
        setlabelHasPicks()
        setRegister()

    }
    override func viewWillAppear(_ animated: Bool) {
        MountainPicksDataManager().apppicks(self)
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.post(name: Notification.Name("middleButtonAppear"), object: nil)
    }

    //MARK: 네비게이션 바
    func navigationBarSet() {
        let height: CGFloat = 75
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.clear
        navbar.delegate = self

        let navItem = UINavigationItem()
        navbar.items = [navItem]
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.topItem?.title = "찜한 산"
        navbar.layoutIfNeeded()
        view.addSubview(navbar)
    }
    
    let viewHasPicks = UIView()
    let labelHasPicks = UILabel()
    let imageViewFace = UIImageView()
    let labelHasPicksExplain = UILabel()
    
    func setlabelHasPicks() {
        view.addSubview(viewHasPicks)
        viewHasPicks.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        viewHasPicks.alpha = 0
        labelHasPicks.text = "산타에 찜한 산이 없어요."
        labelHasPicks.textColor = .bluegray
        labelHasPicks.alpha = 1
        labelHasPicks.textAlignment = .center
        labelHasPicks.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 27)
        viewHasPicks.addSubview(labelHasPicks)
        labelHasPicks.snp.makeConstraints { make in
            make.center.equalTo(viewHasPicks)
        }
        imageViewFace.contentMode = .scaleAspectFit
        imageViewFace.image = UIImage(named: "illustLlikeWow@3x")
        viewHasPicks.addSubview(imageViewFace)
        imageViewFace.snp.makeConstraints { make in
            make.centerX.equalTo(labelHasPicks.snp.centerX)
            make.width.height.equalTo(39)
            make.bottom.equalTo(labelHasPicks.snp.top).offset(-11)
        }
        labelHasPicksExplain.text = "산타와 함께 등산하고 싶은 산을 찜해보세요! 검색 중에\n보이는 하트아이콘을 누르면 찜하기가 됩니다:)"
        labelHasPicksExplain.textAlignment = .center
        labelHasPicksExplain.numberOfLines = 2
        labelHasPicksExplain.textColor = .bluegray
        labelHasPicksExplain.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 14)
        viewHasPicks.addSubview(labelHasPicksExplain)
        labelHasPicksExplain.snp.makeConstraints { make in
            make.centerX.equalTo(labelHasPicks.snp.centerX)
            make.top.equalTo(labelHasPicks.snp.bottom).offset(9)
        }
        
    }
    // MARK: 컬렉션 뷰 등록
    func setRegister() {
        carouselCollectionViewLikeMountain.delegate = self
        carouselCollectionViewLikeMountain.dataSource = self
        carouselCollectionViewLikeMountain.register(LikeMountainCollectionViewCell.self, forCellWithReuseIdentifier: LikeMountainCollectionViewCell.resueidentifier)
        
        view.addSubview(carouselCollectionViewLikeMountain)
        
        carouselCollectionViewLikeMountain.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(view)
            make.top.equalTo(view).offset(75)
        }
    }
}

extension PickMountainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mountainPicks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeMountainCollectionViewCell.resueidentifier, for: indexPath) as? LikeMountainCollectionViewCell {
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 20
            cell.layer.shadowRadius = 5
            cell.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.layer.shadowColor = UIColor(hex: 0x7c909b).cgColor
            cell.layer.shadowOpacity = 0.2
            
            
            if let urlString = mountainPicks[indexPath.row].mountainImg {
                let url = URL(string: urlString)
                cell.imageViewMountain.kf.indicatorType = .activity
                cell.imageViewMountain.kf.setImage(with: url)
            }
            
            if mountainPicks[indexPath.row].difficulty == 1 {
                cell.imageViewDifficulty.image = UIImage(named: "illustHome1@3x")
            }
            else if mountainPicks[indexPath.row].difficulty == 2 {
                cell.imageViewDifficulty.image = UIImage(named: "illustHome2@3x")
            }
            else if mountainPicks[indexPath.row].difficulty == 3 {
                cell.imageViewDifficulty.image = UIImage(named: "illustHome3@3x")
            }
            else if mountainPicks[indexPath.row].difficulty == 4 {
                cell.imageViewDifficulty.image = UIImage(named: "illustHome4@3x")
            }
            else {
                cell.imageViewDifficulty.image = UIImage(named: "illustHome5@3x")
            }
            
            cell.labelMountain.text = mountainPicks[indexPath.row].mountainName
            cell.labelMountainHeight.text = "\(mountainPicks[indexPath.row].intTypeHigh ?? 0)m"
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 38, height: 109)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if let idx = mountainPicks[indexPath.row].mountainIdx, let mountainName = mountainPicks[indexPath.row].mountainName, let mountainHeight = mountainPicks[indexPath.row].intTypeHigh {
            let nextVC = RankingMountainViewController(contentRankingViewController: ContentRankViewController(), contentMountainViewController: ContentMountainViewController())
            nextVC.mountainIndex = idx
            TrackingTool.Action(actionName: "action_go_detail_mountain_like", param: ["mountain_name":mountainName])
            nextVC.mountainName = mountainName
            nextVC.mountainHeight = mountainHeight
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .crossDissolve
            NotificationCenter.default.post(name: Notification.Name("middleButtonHidden"), object: nil)
            tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
}

extension PickMountainViewController {
    func successDataPick(_ result : [MountainPicksResult]) {
        mountainPicks = result
        if result.isEmpty {
            viewHasPicks.alpha = 1
        }
        else {
            viewHasPicks.alpha = 0
        }
        
        carouselCollectionViewLikeMountain.reloadData()
    }
    func failureDataPick() {
        self.presentAlert(title: "네트워크 연결 장애")
    }
}
