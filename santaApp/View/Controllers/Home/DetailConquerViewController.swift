//
//  DetailConquerViewController.swift
//  santaApp
//
//  Created by 노영재 on 2022/01/25.
//

import UIKit

class DetailConquerViewController : BaseViewController {
    var viewModel : [ConquerResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConquerViewModel().appnewHomesflags(self)
        setCollectionView()
        setNavigationBar()
        self.tabBarController?.tabBar.isHidden = true
        NotificationCenter.default.post(name: Notification.Name("middleButtonHidden"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(actionGoNextView), name: Notification.Name("goNextView"), object: nil)
    }
       
    //MARK: navigation
    func setNavigationBar() {
        let height: CGFloat = 75
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: height))
        navbar.delegate = self

        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = self.leftButton
        navbar.items = [navItem]
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.layoutIfNeeded()
        navbar.topItem?.title = "정복 인증샷"
        view.addSubview(navbar)
    }
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .titleColorGray
        return button
    }()
    @objc func actionBackButton(_ sender : Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // 정복 인증샷 collectionView
    let collectionViewConquer: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 17, bottom: 16, right: 17)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setCollectionView() {
        collectionViewConquer.delegate = self
        collectionViewConquer.dataSource = self
        
        collectionViewConquer.register(DetailConquerCollectionViewCell.self, forCellWithReuseIdentifier: DetailConquerCollectionViewCell.resueidentifier)
        
        view.addSubview(collectionViewConquer)
        collectionViewConquer.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view)
            make.top.equalTo(view).offset(75)
        }
    }
}

extension DetailConquerViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailConquerCollectionViewCell.resueidentifier, for: indexPath) as? DetailConquerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.labelUserLv.text = viewModel[indexPath.row].level ?? ""
        cell.labelUserName.text = viewModel[indexPath.row].userName ?? ""
        cell.labelHowManyHeart.text = "\(viewModel[indexPath.row].commentCount ?? 0)"
        cell.labelHowManyMessage.text = "\(viewModel[indexPath.row].saveCount ?? 0)"
        
        if let urlString = viewModel[indexPath.row].userImageUrl {
            let url = URL(string: urlString)
            cell.imageViewUserProfile.kf.indicatorType = .activity
            cell.imageViewUserProfile.kf.setImage(with: url)
        } else {
            cell.imageViewUserProfile.image = UIImage(named: "personhome")
        }
        
        if let urlString = viewModel[indexPath.row].flagImageUrl {
            let url = URL(string: urlString)
            cell.imageViewFeed.kf.indicatorType = .activity
            cell.imageViewFeed.kf.setImage(with: url)
        }
                
        cell.buttonGoDetailMessage.addTarget(self, action: #selector(actionGoNextView), for: .touchUpInside)
        cell.buttonGoDetailMessage.tag = viewModel[indexPath.row].flagIdx ?? 0
        return cell
    }
    
    @objc func actionGoNextView(button: UIButton) {
        let NextVC = DetailMessageViewController()
        NextVC.flagIndex = button.tag
        self.navigationController?.pushViewController(NextVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 341, height: 386)
    }
    
}

extension DetailConquerViewController {
    func successViewModel(_ result : [ConquerResult]) {
        viewModel = result
        collectionViewConquer.reloadData()
    }
}
