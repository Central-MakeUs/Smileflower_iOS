//
//  SearchViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/10.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {

    var mountainResult : [MountainResult] = []
    
    var filterArr : [MountainResult] = []
    
    var isFiltering : Bool {
        let isActive = searchBar.text?.isEmpty == false
        return isActive
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        view.setverticleGradient(color1: UIColor(hex:0x24C7B9) , color2: UIColor(hex: 0x9AC7FF))
        setBottomSheet()
        setSearchBar()
        setViewSearch()
        setLabelRecommend()
        registerCollectionView()
        MountainDataManager().appmountains(self)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.searchBar.becomeFirstResponder()
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
    let searchBar = UISearchBar()
    
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
            make.width.height.equalTo(30)
        }
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.leftView = nil
        searchBar.placeholder = "어떤 산을 찾으세요?"
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .clear
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightbluegray])
        }
        viewSearch.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.centerY.equalTo(buttonBack.snp.centerY)
            make.leading.equalTo(buttonBack.snp.trailing)
            make.trailing.equalTo(viewSearch.snp.trailing).offset(-20)
            make.height.equalTo(40)
        }
    }
    @objc func actionBackView() {
        let nextVC = BaseTabbarController()
        nextVC.index = 0
        self.changeRootViewController(nextVC)
        
    }
    // MARK: SearchBar
    func setSearchBar() {
        self.searchBar.delegate = self
    }
    //MARk: 오늘의 추천산
    let labelRecommend = UILabel()
    let labelRecommendExplain = UILabel()
    
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
        labelRecommend.text = "100대 명산"
        labelRecommend.textColor = .darkbluegray
        labelRecommend.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 18)
        viewBottomSheet.addSubview(labelRecommend)
        labelRecommend.snp.makeConstraints { make in
            make.leading.equalTo(28)
            make.top.equalTo(viewSearch.snp.bottom).offset(10)
        }
        labelRecommendExplain.text = "산타에 등록되어있는 100대 명산을 탐색해보세요:)"
        labelRecommendExplain.textColor = .lightbluegray
        labelRecommendExplain.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 11)
        viewBottomSheet.addSubview(labelRecommendExplain)
        labelRecommendExplain.snp.makeConstraints { make in
            make.leading.equalTo(labelRecommend.snp.trailing).offset(9)
        make.bottom.equalTo(labelRecommend.snp.bottom).offset(-2)
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
        carouselCollectionViewRecommendMountain.delegate = self
        carouselCollectionViewRecommendMountain.dataSource = self
        
        carouselCollectionViewRecommendMountain.register(RecommendMountainCollectionViewCell.self, forCellWithReuseIdentifier: RecommendMountainCollectionViewCell.identifier)
    }
}

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.isFiltering ? self.filterArr.count : self.mountainResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendMountainCollectionViewCell.identifier, for: indexPath) as? RecommendMountainCollectionViewCell {
            cell.backgroundColor = .white
            cell.layer.shadowColor = UIColor(hex: 0xdfe5ed).cgColor
            cell.layer.shadowOpacity = 1
            cell.layer.shadowRadius = 4
            cell.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.layer.cornerRadius = 20
            
            if self.isFiltering {
                cell.labelMountainName.text = filterArr[indexPath.row].mountainName
                cell.labelMountainHeight.text = filterArr[indexPath.row].high
                if let urlString = filterArr[indexPath.row].mountainImg {
                    let url = URL(string: urlString)
                    let processor = DownsamplingImageProcessor(size: cell.imageViewMountain.bounds.size)
                    cell.imageViewMountain.kf.setImage(with: url, options: [.processor(processor)])
                }
                if filterArr[indexPath.row].hot == "T" {
                    cell.imageViewIsHot.image = UIImage(named: "icSearchBest@3x")
                }
                
                if filterArr[indexPath.row].difficulty == 1{
                    cell.imageViewDifficulty.image = UIImage(named: "illustHome1@3x")
                }
                else if filterArr[indexPath.row].difficulty == 2{
                    cell.imageViewDifficulty.image = UIImage(named: "illustHome2@3x")
                }
                else if filterArr[indexPath.row].difficulty == 3{
                    cell.imageViewDifficulty.image = UIImage(named: "illustHome3@3x")
                }
                else if filterArr[indexPath.row].difficulty == 4{
                    cell.imageViewDifficulty.image = UIImage(named: "illustHome4@3x")
                }
                else {
                    cell.imageViewDifficulty.image = UIImage(named: "illustHome5@3x")
                }
                return cell
            }
            else {
                cell.labelMountainName.text = mountainResult[indexPath.row].mountainName
                cell.labelMountainHeight.text = mountainResult[indexPath.row].high
                if let urlString = mountainResult[indexPath.row].mountainImg {
                    let url = URL(string: urlString)
                    cell.imageViewMountain.kf.indicatorType = .activity
                    cell.imageViewMountain.kf.setImage(with: url)
                }
                
                //MARK: 인기 이미지
                if mountainResult[indexPath.row].hot == "인기" {
                    cell.imageViewIsHot.image = UIImage(named: "icSearchBest@3x")
                }
                else {
                    cell.imageViewIsHot.image = UIImage()
                }
                
                //MARK: 찜하기버튼
                cell.mountainIdx = mountainResult[indexPath.row].mountainIdx
                if mountainResult[indexPath.row].pick == "T" {
                    cell.buttonMountainLike.isSelected = true
                }
                else {
                    cell.buttonMountainLike.isSelected = false
                }
                
                //MARK: 난이도 이미지
                if mountainResult[indexPath.row].difficulty == 1{
                    cell.imageViewDifficulty.image = UIImage(named: "illustHome1@3x")
                }
                else if mountainResult[indexPath.row].difficulty == 2{
                    cell.imageViewDifficulty.image = UIImage(named: "illustHome2@3x")
                }
                else if mountainResult[indexPath.row].difficulty == 3{
                    cell.imageViewDifficulty.image = UIImage(named: "illustHome3@3x")
                }
                else if mountainResult[indexPath.row].difficulty == 4{
                    cell.imageViewDifficulty.image = UIImage(named: "illustHome4@3x")
                }
                else {
                    cell.imageViewDifficulty.image = UIImage(named: "illustHome5@3x")
                }
                return cell
            }
            
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
            return CGSize(width: 333, height: 91)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFiltering {
            if let idx = filterArr[indexPath.row].mountainIdx, let mountainName = filterArr[indexPath.row].mountainName {
                let nextVC = RankingMountainViewController(contentRankingViewController: ContentRankViewController(), contentMountainViewController: ContentMountainViewController())
                nextVC.mountainIndex = idx
                nextVC.mountainName = mountainName
                    nextVC.modalPresentationStyle = .fullScreen
                    nextVC.modalTransitionStyle = .crossDissolve
                    self.present(nextVC, animated: true, completion: nil)
            }
        }
        else {
            if let idx = mountainResult[indexPath.row].mountainIdx, let mountainName = mountainResult[indexPath.row].mountainName {
                let nextVC = RankingMountainViewController(contentRankingViewController: ContentRankViewController(), contentMountainViewController: ContentMountainViewController())
                nextVC.mountainIndex = idx
                nextVC.mountainName = mountainName
                    nextVC.modalPresentationStyle = .fullScreen
                    nextVC.modalTransitionStyle = .crossDissolve
                    self.present(nextVC, animated: true, completion: nil)
            }
        }
       
        
    }
}
extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
            return
        }
        self.filterArr = self.mountainResult.filter({ MountainResult in
            guard let name = MountainResult.mountainName else {
                return false
            }
            return name.contains(text)
        })
        self.carouselCollectionViewRecommendMountain.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
            let input = MountainSearchInput(mountain: searchBar.text)
            MountainSearchDataManager().appmountainssearchmountain(self, input)
            
    }
    
    
}

extension SearchViewController {
    func successDataMountain(_ result : [MountainResult]) {
        mountainResult = result
        self.carouselCollectionViewRecommendMountain.reloadData()
    }
    func successDataMountainSearch(_ result : MountainSearchResult) {
        if let idx = result.mountainIdx {
            let nextVC = RankingMountainViewController(contentRankingViewController: ContentRankViewController(), contentMountainViewController: ContentMountainViewController())
            nextVC.mountainIndex = idx
            nextVC.mountainName = searchBar.text!
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .crossDissolve
            self.present(nextVC, animated: true, completion: nil)
        }
        
    }
    func failDataMountain(_ title : String) {
        self.presentAlert(title: title)
    }
}
