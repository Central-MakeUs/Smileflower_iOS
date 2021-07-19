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
        navigationBarSet()
        setlabelHasPicks()
        setRegister()

    }
    override func viewWillAppear(_ animated: Bool) {
        MountainPicksDataManager().apppicks(self)
    }

    
    let labelHasPicks = UILabel()
    func setlabelHasPicks() {
        labelHasPicks.text = "찜한 산이 없습니다."
        labelHasPicks.textColor = .titleColorGray
        labelHasPicks.alpha = 0
        labelHasPicks.textAlignment = .center
        labelHasPicks.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 27)
        view.addSubview(labelHasPicks)
        labelHasPicks.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    // MARK: 네비게이션 바 설정
    func navigationBarSet() {
        navigationItem.title = "찜한 산"
    }
    // MARK: 컬렉션 뷰 등록
    func setRegister() {
        carouselCollectionViewLikeMountain.delegate = self
        carouselCollectionViewLikeMountain.dataSource = self
        carouselCollectionViewLikeMountain.register(LikeMountainCollectionViewCell.self, forCellWithReuseIdentifier: LikeMountainCollectionViewCell.resueidentifier)
        
        view.addSubview(carouselCollectionViewLikeMountain)
        
        carouselCollectionViewLikeMountain.snp.makeConstraints { make in
            make.edges.equalTo(view)
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
            cell.layer.shadowRadius = 10
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
            cell.labelMountainHeight.text = mountainPicks[indexPath.row].mountainName
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 38, height: 109)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if let idx = mountainPicks[indexPath.row].mountainIdx {
            let nextVC = RankingMountainViewController(contentRankingViewController: ContentRankViewController(), contentMountainViewController: ContentMountainViewController())
            nextVC.mountainIndex = idx
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .crossDissolve
            self.present(nextVC, animated: true, completion: nil)
        }
        
    }
}

extension PickMountainViewController {
    func successDataPick(_ result : [MountainPicksResult]) {
        mountainPicks = result
        if result.isEmpty {
            labelHasPicks.alpha = 1
        }
        else {
            labelHasPicks.alpha = 0
        }
        
        carouselCollectionViewLikeMountain.reloadData()
    }
    func failureDataPick() {
        self.presentAlert(title: "네트워크 연결 장애")
    }
}
