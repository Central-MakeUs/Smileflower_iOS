//
//  DetailPosteViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/09.
//

import UIKit
import Kingfisher

class DetailAnotherUserViewController: BaseViewController {
    
//    var postsResult : [DetailAnotherUserPosts] = []
    var userIdx : Int?
    var userName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationBarSet()
        SetCollectionViewContent()
        if let idx = userIdx {
//            DetailAnotherUserDataManager().apiprofileuserIdxposts(self, idx)
        }
    }
    // MARK: 네비게이션 바
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .titleColorGray
        return button
        
    }()
    func navigationBarSet() {
        let height: CGFloat = 60
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self

        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = self.leftButton
        navbar.items = [navItem]
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.layoutIfNeeded()
        navbar.topItem?.title = (userName ?? "") + "의 게시물"
        view.addSubview(navbar)
    }
    @objc func actionBackButton(_ sender : Any) {
        let vc = BaseTabbarController()
        vc.index = 0
        self.changeRootViewController(vc)
    }
    //MARK: 컬렉션 뷰
    let carouselCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 20.2
        flowLayout.sectionInset = UIEdgeInsets(top: 17, left: 8, bottom: 17, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    func SetCollectionViewContent() {
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        
        carouselCollectionView.register(DetailAnotherUserCollectionViewCell.self, forCellWithReuseIdentifier: DetailAnotherUserCollectionViewCell.reuseIdentifier)
        view.addSubview(carouselCollectionView)
        carouselCollectionView.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalTo(view)
            make.top.equalTo(view.snp.top).offset(119)
        }
    }
}
extension DetailAnotherUserViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
//        return postsResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailAnotherUserCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailAnotherUserCollectionViewCell {
//            if let urlString = postsResult[indexPath.row].pictureUrl {
//               let url = URL(string: urlString)
//                cell.imageViewMountain.kf.setImage(with: url)
//            }
//            if let dateStr = postsResult[indexPath.row].createdAt {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                let converData = dateFormatter.date(from: dateStr)
//                let myDateFormatter = DateFormatter()
//                myDateFormatter.dateFormat = "yyyy년 MM월 dd일\n a hh시 mm분"
//                myDateFormatter.locale = Locale(identifier: "ko_KR")
//                let convertStr = myDateFormatter.string(from: converData!)
//                cell.labelDateAndTime.text = convertStr
//            }
//            if postsResult[indexPath.row].isFlag! {
//                cell.imageViewFlag.image = UIImage(named: "FlagIcon@3x")
//            }
//            else {
//                cell.imageViewFlag.image = UIImage()
//            }
//            cell.labelMountainName.text = postsResult[indexPath.row].name ?? "게시물"
//            cell.flagIdx = postsResult[indexPath.row].flagIdx
//            cell.userIdx = postsResult[indexPath.row].userIdx
//            cell.pictureIdx = postsResult[indexPath.row].picturesIdx
//            cell.detailAnotherUserViewController = self
            return cell
        }
        return UICollectionViewCell()
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = UIScreen.main.bounds.width - 16
        return CGSize(width: widthCell, height: widthCell * 1.16)
    }
    
}


extension DetailAnotherUserViewController {
//    func successDataApi(_ result : DetailAnotherUserResponse) {
//        postsResult = result.posts!
//        userName = result.name
//        carouselCollectionView.reloadData()
//    }
    func failDataApi(_ message : String) {
        self.presentAlert(title: message)
    }
}
