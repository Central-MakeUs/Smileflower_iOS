//
//  DetailPosteViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/09.
//

import UIKit
import Kingfisher

class DetailPosteViewController: BaseViewController, UINavigationBarDelegate {
    
    var postsResult : [DetailPostsPosts] = []
    var userIdx : Int?
    var indexPath : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationBarSet()
        SetCollectionViewContent()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let idx = userIdx {
            DetailPostsDataManager().apiprofileuserIdxposts(self, idx)
        }
    }
    override func viewWillLayoutSubviews() {
        if let numindex = indexPath {
            carouselCollectionView.scrollToItem(at: IndexPath(item: numindex, section: 0), at: .bottom, animated: false)
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
        navbar.topItem?.title = "내 게시물"
        view.addSubview(navbar)
    }
    @objc func actionBackButton(_ sender : Any) {
        let vc = BaseTabbarController()
        vc.index = 3
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
        
        carouselCollectionView.register(DetailPostCollectionViewCell.self, forCellWithReuseIdentifier: DetailPostCollectionViewCell.reuseIdentifier)
        view.addSubview(carouselCollectionView)
        carouselCollectionView.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalTo(view)
            make.top.equalTo(view.snp.top).offset(119)
        }
    }
}
extension DetailPosteViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPostCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailPostCollectionViewCell {
            if let urlString = postsResult[indexPath.row].pictureUrl {
               let url = URL(string: urlString)
                cell.imageViewMountain.kf.setImage(with: url)
            }
            if let dateStr = postsResult[indexPath.row].createdAt {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let converData = dateFormatter.date(from: dateStr)
                let myDateFormatter = DateFormatter()
                myDateFormatter.dateFormat = "yyyy년 MM월 dd일\na hh시 mm분"
                myDateFormatter.locale = Locale(identifier: "ko_KR")
                let convertStr = myDateFormatter.string(from: converData!)
                cell.labelDateAndTime.text = convertStr
            }
            if postsResult[indexPath.row].isFlag! {
                cell.imageViewFlag.image = UIImage(named: "FlagIcon@3x")
            }
            else {
                cell.imageViewFlag.image = UIImage()
            }
            cell.detailPostViewController = self
            cell.userIdx = userIdx
            cell.isFlag = postsResult[indexPath.row].isFlag ?? true
            cell.postsIdx = postsResult[indexPath.row].pictureIdx
            cell.flagsIdx = postsResult[indexPath.row].flagIdx
            cell.labelMountainName.text = postsResult[indexPath.row].name ?? "게시물"
                return cell
        }
        return UICollectionViewCell()
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = UIScreen.main.bounds.width - 16
        return CGSize(width: widthCell, height: widthCell * 1.16)
    }
    
}

extension DetailPosteViewController {
    func successDataApiPosts(_ result : DetailPostsResponse) {
        postsResult = result.posts!
        carouselCollectionView.reloadData()
    }
    func failureDataApiPosts(_ message : String) {
        self.presentAlert(title: message)
    }
}
