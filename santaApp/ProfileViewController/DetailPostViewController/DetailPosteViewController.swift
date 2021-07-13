//
//  DetailPosteViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/09.
//

import UIKit

class DetailPosteViewController: UIViewController, UINavigationBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationBarSet()
        SetCollectionViewContent()
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPostCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailPostCollectionViewCell {
            cell.labelMountainName.text = "인왕산"
            cell.labelDateAndTime.text = "2021년 6월28일\n오후 2:18"
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = UIScreen.main.bounds.width - 16
        return CGSize(width: widthCell, height: widthCell * 1.16)
    }
    
}
