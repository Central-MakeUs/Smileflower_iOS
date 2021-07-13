//
//  SearchViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/10.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setverticleGradient(color1: UIColor(hex:0x24C7B9) , color2: UIColor(hex: 0x9AC7FF))
        setBottomSheet()
        setViewSearch()
        setLatestSearch()
        setLabelRecommend()
        registerCollectionView()
    }
    //MARK: 바텀 시트 구현
    let viewBottomSheet : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        view.clipsToBounds = true
        return view
    }()
    var bottomSheetPanMinTopConstant: CGFloat =  -20
       // 드래그 하기 전에 Bottom Sheet의 top Constraint value를 저장하기 위한 프로퍼티
    private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    func setBottomSheet() {
        
        view.addSubview(viewBottomSheet)
        let topConstant : CGFloat = 20
        viewBottomSheet.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetViewTopConstraint = viewBottomSheet.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
                NSLayoutConstraint.activate([
                    viewBottomSheet.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    viewBottomSheet.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    viewBottomSheet.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    bottomSheetViewTopConstraint,
                ])
        viewBottomSheet.layer.zPosition = 999
    }
    //MARK: 서치바 있을 뷰 구현
    let viewSearch = UIView()
    let buttonBack = UIButton()
    let buttonFilter = UIButton()
    
    func setViewSearch() {
        viewBottomSheet.addSubview(viewSearch)
        viewSearch.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(viewBottomSheet)
            make.height.equalTo(68)
        }
        buttonBack.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        buttonBack.tintColor = .titleColorGray
        buttonBack.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        buttonBack.addTarget(self, action: #selector(actionBackView), for: .touchUpInside)
        viewSearch.addSubview(buttonBack)
        buttonBack.snp.makeConstraints { make in
            make.centerY.equalTo(viewSearch.snp.centerY)
            make.leading.equalTo(viewSearch.snp.leading).offset(2)
            make.width.height.equalTo(42)
        }
        buttonFilter.setImage(UIImage(named: "icSearchFilter@3x"), for: .normal)
        buttonBack.addTarget(self, action: #selector(actionFilter), for: .touchUpInside)
        viewSearch.addSubview(buttonFilter)
        buttonFilter.snp.makeConstraints { make in
            make.centerY.equalTo(buttonBack.snp.centerY)
            make.trailing.equalTo(viewSearch.snp.trailing).offset(-18)
            make.width.height.equalTo(42)
        }
    }
    @objc func actionBackView() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func actionFilter() {
        print("click")
    }
    //MARK: 최근 검색어
    let labelLatestSearch = UILabel()
    let carouselCollectionViewLatestSearch : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setLatestSearch() {
        labelLatestSearch.text = "최근 검색 기록"
        labelLatestSearch.textColor = .darkbluegray
        labelLatestSearch.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)
        viewBottomSheet.addSubview(labelLatestSearch)
        labelLatestSearch.snp.makeConstraints { make in
            make.leading.equalTo(28)
            make.top.equalTo(viewSearch.snp.bottom).offset(6)
        }
        viewBottomSheet.addSubview(carouselCollectionViewLatestSearch)
        carouselCollectionViewLatestSearch.snp.makeConstraints { make in
            make.top.equalTo(labelLatestSearch.snp.bottom).offset(9)
            make.leading.trailing.equalTo(viewBottomSheet)
            make.height.equalTo(50)
        }
    }
    //MARk: 오늘의 추천산
    let labelRecommend = UILabel()
    let carouselCollectionViewRecommendMountain : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 9
        flowLayout.sectionInset = UIEdgeInsets(top: 9, left: (UIScreen.main.bounds.width - 333)/2, bottom: 9, right: (UIScreen.main.bounds.width - 333)/2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    func setLabelRecommend() {
        labelRecommend.text = "오늘의 추천 산"
        labelRecommend.textColor = .darkbluegray
        labelRecommend.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)
        viewBottomSheet.addSubview(labelRecommend)
        labelRecommend.snp.makeConstraints { make in
            make.leading.equalTo(28)
            make.top.equalTo(carouselCollectionViewLatestSearch.snp.bottom).offset(27)
        }
        viewBottomSheet.addSubview(carouselCollectionViewRecommendMountain)
        carouselCollectionViewRecommendMountain.snp.makeConstraints { make in
            make.top.equalTo(labelRecommend.snp.bottom)
            make.leading.trailing.bottom.equalTo(0)
        }
    }
    //
    // MARK: 컬렉션 뷰 등록
    func registerCollectionView() {
        carouselCollectionViewLatestSearch.delegate = self
        carouselCollectionViewLatestSearch.dataSource = self
        carouselCollectionViewRecommendMountain.delegate = self
        carouselCollectionViewRecommendMountain.dataSource = self
        
        carouselCollectionViewLatestSearch.register(LatestSearchCollectionViewCell.self, forCellWithReuseIdentifier: LatestSearchCollectionViewCell.identifier)
        carouselCollectionViewRecommendMountain.register(RecommendMountainCollectionViewCell.self, forCellWithReuseIdentifier: RecommendMountainCollectionViewCell.identifier)
    }
}

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == carouselCollectionViewLatestSearch {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestSearchCollectionViewCell.identifier, for: indexPath) as? LatestSearchCollectionViewCell {
                cell.label.text = "인왕산"
                return cell
            }
            return UICollectionViewCell()
        }
        else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendMountainCollectionViewCell.identifier, for: indexPath) as? RecommendMountainCollectionViewCell {
                cell.backgroundColor = .white
                cell.layer.shadowColor = UIColor(hex: 0xdfe5ed).cgColor
                cell.layer.shadowOpacity = 0.9
                cell.layer.shadowRadius = 6
                cell.layer.shadowOffset = CGSize(width: 0, height: 3)
                cell.layer.cornerRadius = 20
                
                cell.labelMountainName.text = "인왕산"
                cell.labelMountainHeight.text = "(330.8m)"
                return cell
            }
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == carouselCollectionViewLatestSearch {
            return CGSize(width: 75, height: 32)
        }
        else {
            return CGSize(width: 333, height: 91)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == carouselCollectionViewLatestSearch {
            
        }
        else {
            let nextVC = RankingMountainViewController(contentRankingViewController: ContentRankViewController(), contentMountainViewController: ContentMountainViewController())
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .crossDissolve
            self.present(nextVC, animated: true, completion: nil)
        }
    }
}
