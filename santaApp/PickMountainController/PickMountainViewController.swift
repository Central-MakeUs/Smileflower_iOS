//
//  PickMountainViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import UIKit

class PickMountainViewController : BaseViewController {
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
        setRegister()
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeMountainCollectionViewCell.resueidentifier, for: indexPath) as? LikeMountainCollectionViewCell {
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 20
            cell.layer.shadowRadius = 10
            cell.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.layer.shadowColor = UIColor(hex: 0x7c909b).cgColor
            cell.layer.shadowOpacity = 0.2
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 38, height: 109)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let nextVC = RankingMountainViewController(contentRankingViewController: ContentRankViewController(), contentMountainViewController: ContentMountainViewController())
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
}
