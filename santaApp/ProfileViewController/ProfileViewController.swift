//
//  ProfileViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import UIKit
import BetterSegmentedControl
import Photos

class ProfileViewController : BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSet()
        scrollViewSet()
        buttonSetSeeMap()
        viewSetContent()
        viewSet()
        viewSetImageCollection()
    }
    //MARK: 네비게이션
    func navigationBarSet() {
        navigationItem.title = "프로필"
    }
    //MARK: 스크롤뷰 구현
    let scrollViewContent = UIScrollView()
    
    func scrollViewSet() {
        scrollViewContent.backgroundColor = .white
        scrollViewContent.isScrollEnabled = false
        scrollViewContent.showsHorizontalScrollIndicator = false
        scrollViewContent.showsVerticalScrollIndicator = false
        scrollViewContent.delegate = self
        view.addSubview(scrollViewContent)
        scrollViewContent.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    //MAKR: ContentView 구현
    let viewContent = UIView()
    
    func viewSetContent() {
        scrollViewContent.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(scrollViewContent)
            make.bottom.equalTo(scrollViewContent.snp.bottom).offset(-25)
            make.height.equalTo(UIScreen.main.bounds.height + 40)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }
    // MARK: 지도로 보기 버튼 구현
    let buttonSeeMap = UIButton()
    func buttonSetSeeMap() {
        buttonSeeMap.backgroundColor = .white
        buttonSeeMap.layer.borderWidth = 1
        buttonSeeMap.layer.borderColor = UIColor.mainColor.cgColor
        buttonSeeMap.setTitle("지도", for: .normal)
        buttonSeeMap.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        buttonSeeMap.setTitleColor(.mainColor, for: .normal)
        buttonSeeMap.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 5)
        buttonSeeMap.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        buttonSeeMap.setImage(UIImage(named: "IconMap@3x"), for: .normal)
        buttonSeeMap.semanticContentAttribute = .forceLeftToRight
        view.addSubview(buttonSeeMap)
        buttonSeeMap.layer.zPosition = 999
        buttonSeeMap.layer.cornerRadius = 18
        buttonSeeMap.snp.makeConstraints { make in
            make.bottom.equalTo(-124)
            make.trailing.equalTo(-19)
            make.width.equalTo(88)
            make.height.equalTo(36)
        }
    }
    //MARK: 프로필뷰
    let viewProfile = UIView()
    
    func viewSet() {
        viewProfile.backgroundColor = .white
        viewContent.addSubview(viewProfile)
        viewProfile.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(viewContent)
            make.height.equalTo(240)
        }
        viewSetUser()
        stackViewSet()
    }
    //MARK: 사용자 프로필
    let viewUser = UIButton()
    let labelUserName = UILabel()
    let picker = UIImagePickerController()
    let imageViewUserProfile = UIImageView()
    
    func viewSetUser() {
        picker.delegate = self
        viewUser.backgroundColor = .white
        viewUser.layer.cornerRadius = 44
        viewUser.layer.shadowColor = UIColor(hex: 0xc1cad0).cgColor
        viewUser.layer.shadowOpacity = 0.55
        viewUser.layer.shadowRadius = 4
        viewUser.layer.shadowOffset = CGSize(width: 1, height: 4)
        viewUser.addTarget(self, action: #selector(actionGoPhotoLibrary), for: .touchUpInside)
        viewProfile.addSubview(viewUser)
        viewUser.snp.makeConstraints { make in
            make.width.height.equalTo(88)
            make.centerX.equalTo(viewContent.snp.centerX)
            make.top.equalTo(viewContent.snp.top).offset(25)
        }
        labelUserName.text = "에스핀"
        labelUserName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 22)
        labelUserName.textColor = .darkbluegray
        labelUserName.textAlignment = .center
        viewProfile.addSubview(labelUserName)
        labelUserName.snp.makeConstraints { make in
            make.top.equalTo(viewUser.snp.bottom).offset(8)
            make.centerX.equalTo(viewContent.snp.centerX)
            make.width.equalTo(156)
        }
        imageViewUserProfile.image = UIImage(named: "1083@3x")
        imageViewUserProfile.contentMode = .scaleAspectFill
        viewUser.addSubview(imageViewUserProfile)
        imageViewUserProfile.clipsToBounds = true
        imageViewUserProfile.layer.cornerRadius = 39.4
        imageViewUserProfile.snp.makeConstraints { make in
            make.center.equalTo(viewUser)
            make.width.height.equalTo(78.8)
        }
    }
    @objc func actionGoPhotoLibrary() {
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        self.present(picker, animated: true, completion: nil)
    }
    //MAKR: 레벨, 꽂은 깃발, 게시물 구성
    let stackView = UIStackView()
    let viewUserLv = UIView()
    let viewFlag = UIView()
    let viewPost = UIView()
    
    func stackViewSet() {
        self.stackView.backgroundColor = UIColor(hex: 0xc1cad0, alpha: 0.3)
        self.stackView.axis = .horizontal
        self.stackView.alignment = .fill
        self.stackView.distribution = .fillEqually
        self.stackView.spacing = 1
        viewUserLv.backgroundColor = .white
        viewFlag.backgroundColor = .white
        viewPost.backgroundColor = .white
        viewProfile.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(viewContent.snp.centerX)
            make.top.equalTo(labelUserName.snp.bottom).offset(20)
            make.width.equalTo(332)
            make.height.equalTo(60)
        }
        //MARK: 레벨 라벨
        let labelLv = UILabel()
        let labelLvConstant = UILabel()
        labelLv.text = "레벨"
        labelLv.textColor = .titleColorGray
        labelLv.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
        labelLvConstant.text  = "14"
        labelLvConstant.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 24)
        labelLvConstant.textAlignment = .center
        viewUserLv.addSubview(labelLv)
        viewUserLv.addSubview(labelLvConstant)
        labelLv.snp.makeConstraints { make in
            make.centerX.equalTo(viewUserLv.snp.centerX)
            make.top.equalTo(viewUserLv.snp.top).offset(6)
        }
        labelLvConstant.snp.makeConstraints { make in
            make.centerX.equalTo(viewUserLv.snp.centerX)
            make.top.equalTo(labelLv.snp.bottom).offset(3)
            make.width.equalTo(45)
        }
        //MARK: 뽑은 깃발
        let labelFlag = UILabel()
        let labelFlagConstant = UILabel()
        labelFlag.text = "꽂은 깃발"
        labelFlag.textColor = .titleColorGray
        labelFlag.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
        labelFlagConstant.text  = "9"
        labelFlagConstant.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 24)
        labelFlagConstant.textAlignment = .center
        viewFlag.addSubview(labelFlag)
        viewFlag.addSubview(labelFlagConstant)
        labelFlag.snp.makeConstraints { make in
            make.centerX.equalTo(viewFlag.snp.centerX)
            make.top.equalTo(viewFlag.snp.top).offset(6)
        }
        labelFlagConstant.snp.makeConstraints { make in
            make.centerX.equalTo(viewFlag.snp.centerX)
            make.top.equalTo(labelFlag.snp.bottom).offset(3)
            make.width.equalTo(45)
        }
        //MARK: 게시물
        let labelPost = UILabel()
        let labelPostConstant = UILabel()
        labelPost.text = "게시물"
        labelPost.textColor = .titleColorGray
        labelPost.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
        labelPostConstant.text  = "20"
        labelPostConstant.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 24)
        labelPostConstant.textAlignment = .center
        viewPost.addSubview(labelPost)
        viewPost.addSubview(labelPostConstant)
        labelPost.snp.makeConstraints { make in
            make.centerX.equalTo(viewPost.snp.centerX)
            make.top.equalTo(viewPost.snp.top).offset(6)
        }
        labelPostConstant.snp.makeConstraints { make in
            make.centerX.equalTo(viewPost.snp.centerX)
            make.top.equalTo(labelPost.snp.bottom).offset(3)
            make.width.equalTo(45)
        }
        
        stackView.addArrangedSubview(viewUserLv)
        stackView.addArrangedSubview(viewFlag)
        stackView.addArrangedSubview(viewPost)
        
    }
    //MARK: 정복한산과 성과
    let viewImageCollection = UIView()
    func viewSetImageCollection() {
        viewImageCollection.backgroundColor = .white
        viewContent.addSubview(viewImageCollection)
        viewImageCollection.snp.makeConstraints { make in
            make.top.equalTo(viewProfile.snp.bottom).offset(0.1)
            make.leading.trailing.bottom.equalTo(viewContent)
        }
        seguecontrolSet()
        setRegister()
    }
    //MARK: seguement Control
    @objc func segconChanged(_ sender : BetterSegmentedControl) {
        switch sender.index {
        case 0:
            UIView.animate(withDuration: 0.5) {
                self.collectionViewConquerMountain.alpha = 1
                self.collectionViewUserResult.alpha = 0
            }
            self.collectionViewConquerMountain.setContentOffset(CGPoint(x: 0, y: 0), animated: false)

        case 1:
            UIView.animate(withDuration: 0.5) {
                self.collectionViewConquerMountain.alpha = 0
                self.collectionViewUserResult.alpha = 1
            }
            self.collectionViewUserResult.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        default: return
        }
    }
    let control = BetterSegmentedControl(
        frame: CGRect(x: UIScreen.main.bounds.maxX/2 - 88 , y: 17, width: 184, height: 36),
        segments: LabelSegment.segments(withTitles: ["정복한 산","성과"],
                                        normalFont: UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)!,
                                        normalTextColor: .titleColorGray,
                                        selectedFont: UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)!,
                                        selectedTextColor: .white),
        index: 0,
        options: [.backgroundColor(UIColor(hex: 0x7C909B, alpha: 0.15)),
                  .indicatorViewBackgroundColor(.mainColor),
                  .indicatorViewInset(4),
                  .animationDuration(0.5)
                  ])
    func seguecontrolSet() {
        control.indicatorView.layer.shadowColor = UIColor.mainColor.cgColor
        control.indicatorView.layer.shadowRadius = 18
        control.indicatorView.layer.shadowOpacity = 0.3
        control.indicatorView.layer.shadowOffset = CGSize(width: 0, height: 0)
        control.cornerRadius = 18
        control.addTarget(self, action: #selector(segconChanged(_:)), for: .valueChanged)
        viewImageCollection.addSubview(control)
    }
    //MARK: 정복한 산 CollectionView
    let collectionViewConquerMountain: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 7
        flowLayout.minimumInteritemSpacing = 7
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 14, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.decelerationRate = .init(rawValue: 0.20)
        return collectionView
    }()
    let collectionViewUserResult: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 7
        flowLayout.minimumInteritemSpacing = 7
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 14, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.decelerationRate = .init(rawValue: 0.20)
        return collectionView
    }()
    
    func setRegister() {
        collectionViewConquerMountain.delegate = self
        collectionViewConquerMountain.dataSource = self
        collectionViewConquerMountain.register(ConquerMountainCollectionViewCell.self, forCellWithReuseIdentifier: ConquerMountainCollectionViewCell.reuseIdentifier)
        
        collectionViewUserResult.delegate = self
        collectionViewUserResult.dataSource = self
        collectionViewUserResult.register(UserResultCollectionViewCell.self, forCellWithReuseIdentifier: UserResultCollectionViewCell.reuseIdentifier)
        collectionViewUserResult.alpha = 0
        
        viewImageCollection.addSubview(collectionViewConquerMountain)
        collectionViewConquerMountain.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(viewImageCollection)
            make.top.equalTo(control.snp.bottom).offset(14)
        }
        viewImageCollection.addSubview(collectionViewUserResult)
        collectionViewUserResult.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(viewImageCollection)
            make.top.equalTo(control.snp.bottom).offset(14)
        }
    }
    
}

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewConquerMountain {
            let nextVC = DetailPosteViewController()
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .crossDissolve
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewConquerMountain {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConquerMountainCollectionViewCell.reuseIdentifier, for: indexPath) as? ConquerMountainCollectionViewCell {
                cell.backgroundColor = .bluegray
                cell.layer.cornerRadius = 10
                return cell
            }
            return UICollectionViewCell()
        }
        else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserResultCollectionViewCell.reuseIdentifier, for: indexPath) as? UserResultCollectionViewCell {
                cell.backgroundColor = .darkbluegray
                cell.layer.cornerRadius = 10
                return cell
            }
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 46) / 3, height: (collectionView.bounds.width - 46) / 3)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionViewConquerMountain {
            if scrollView.contentOffset.y > 0 {
                scrollViewContent.setContentOffset(CGPoint(x: 0, y: 148), animated: true)

            }
        }
        else if scrollView == collectionViewUserResult {
            if scrollView.contentOffset.y > 0 {
                scrollViewContent.setContentOffset(CGPoint(x: 0, y: 148), animated: true)

            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == collectionViewConquerMountain {
            if scrollView.contentOffset.y > 0 {
                scrollViewContent.setContentOffset(CGPoint(x: 0, y: 148), animated: true)

            }
        }
        else if scrollView == collectionViewUserResult {
            if scrollView.contentOffset.y > 0 {
                scrollViewContent.setContentOffset(CGPoint(x: 0, y: 148), animated: true)

            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionViewConquerMountain {
            if scrollView.contentOffset.y < 0 {
                scrollView.contentOffset.y = 0
                scrollViewContent.setContentOffset(CGPoint(x: 0, y: -88), animated: true)
            }
            
        }
        else if scrollView == collectionViewUserResult {
            if scrollView.contentOffset.y < 0 {
                scrollView.contentOffset.y = 0
                scrollViewContent.setContentOffset(CGPoint(x: 0, y: -88), animated: true)
            }
        }
        else if scrollView == scrollViewContent {
            if scrollView.contentOffset.y < -88 {
                scrollView.contentOffset.y = -88
            }
        }
    }
}
//MAKR: 이미지픽 사용
extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewUserProfile.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
