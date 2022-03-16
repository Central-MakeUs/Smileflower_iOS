//
//  DetailConquerViewController.swift
//  santaApp
//
//  Created by 노영재 on 2022/01/25.
//

import UIKit

class DetailUserViewController : BaseViewController {
    var viewModel : [DetailUserPostsPosts] = []
    var userIdx : Int?
    var userName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setNavigationBar()
        if let input = self.userIdx {
            DetailUserDataManager().apiprofileuserIdxposts(self, input)
        }
        
//        NotificationCenter.default.addObserver(self, selector: #selector(actionGoNextView), name: Notification.Name("goNextView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: Notification.Name("reloadProfile"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        NotificationCenter.default.post(name: Notification.Name("middleButtonHidden"), object: nil)
    }
    @objc func reloadCollectionView() {
        if let input = self.userIdx {
            DetailUserDataManager().apiprofileuserIdxposts(self, input)
        }
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
        navbar.topItem?.title = "\(userName ?? "")님의 게시글"
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
    let collectionViewPost: UICollectionView = {
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
        collectionViewPost.delegate = self
        collectionViewPost.dataSource = self
        
        collectionViewPost.register(DetailUserCollectionViewCell.self, forCellWithReuseIdentifier: DetailUserCollectionViewCell.resueidentifier)
        
        view.addSubview(collectionViewPost)
        collectionViewPost.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view)
            make.top.equalTo(view).offset(75)
        }
    }
}

extension DetailUserViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.count)
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailUserCollectionViewCell.resueidentifier, for: indexPath) as? DetailUserCollectionViewCell else {
            return UICollectionViewCell()
        }
        //상단 피드 만들기
        if let mountainName =  viewModel[indexPath.row].name {
            cell.labelMountainName.text = mountainName
        } else {
            cell.labelMountainHeight.isHidden = true
            cell.imageViewPosition.isHidden = true
            cell.imageViewMountainHeight.isHidden = true
            cell.labelMountainName.isHidden = true
        }
        if let date = viewModel[indexPath.row].createdAt {
            let result = date.components(separatedBy: " ")
            // 년월일
            let result1 = result[0].components(separatedBy: "-")
            // 시간
            let result2 = result[1].components(separatedBy: ":")
            cell.labelMountainTime.text = "\(result1[0])년 \(result1[1])월 \(result1[2])일 \(result2[0])시 \(result2[1])분"
        }
        if let urlString = viewModel[indexPath.row].pictureUrl {
            let url = URL(string: urlString)
            cell.imageViewFeed.kf.indicatorType = .activity
            cell.imageViewFeed.kf.setImage(with: url)
        }
        if let flag = viewModel[indexPath.row].flag {
            if !flag {
                cell.imageViewFlag.isHidden = true
            }
        }

        if let urlString = viewModel[indexPath.row].userImageUrl {
            let url = URL(string: urlString)
            cell.imageViewUserProfile.kf.indicatorType = .activity
            cell.imageViewUserProfile.kf.setImage(with: url)
        }
        if viewModel[indexPath.row].isSaved == "T" {
            cell.buttonisHeart.isSelected = true
        } else {
            cell.buttonisHeart.isSelected = false
        }
        cell.labelUserLv.text = viewModel[indexPath.row].level
        cell.labelUserName.text = viewModel[indexPath.row].userName
        cell.labelHowManyHeart.text = "\(viewModel[indexPath.row].saveCount ?? 0)"
        //코멘트 다는 부분
        if let comments = viewModel[indexPath.row].getCommentRes {
            cell.labelHowManyMessage.text = "\(comments.count)"
            if comments.count != 0 {
                if let urlString = comments[0].userImageUrl {
                    let url = URL(string: urlString)
                    cell.imageViewMessageUserProfile.kf.indicatorType = .activity
                    cell.imageViewMessageUserProfile.kf.setImage(with: url)
                } else {
                    cell.imageViewMessageUserProfile.image = UIImage(named: "personhome")
                }
                let contentsString = "\(comments[0].userName ?? "") \(comments[0].contents ?? "")"
                let fontSize = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 14)
                let attributeStr = NSMutableAttributedString(string: contentsString)
                attributeStr.addAttribute(.font, value: fontSize, range: NSRange.init(location: 0, length: comments[0].userName?.count ?? 0))
                cell.labelFeedMessage.attributedText = attributeStr
                cell.imageViewMessageUserProfile.isHidden = false
                cell.labelFeedMessage.isHidden = false
                cell.buttonGoDetailMessage.isHidden = false
                cell.buttonGoDetailMessage.setTitle("\(comments.count ?? 0)개의 댓글 모두 보기", for: .normal)

            } else {
                cell.imageViewMessageUserProfile.isHidden = true
                cell.labelFeedMessage.isHidden = true
                cell.buttonGoDetailMessage.isHidden = true
            }
        }
//        cell.buttonGoDetailMessage.addTarget(self, action: #selector(actionGoNextView), for: .touchUpInside)
        if let tag = viewModel[indexPath.row].flagIdx {
            cell.buttonGoDetailMessage.tag =  tag
            cell.buttonisHeart.tag = tag
        } else {
            cell.buttonGoDetailMessage.tag = viewModel[indexPath.row].pictureIdx ?? 0
            cell.buttonisHeart.tag = viewModel[indexPath.row].pictureIdx ?? 0
        }
        if viewModel[indexPath.row].flag ?? true {
            cell.buttonMore.titleLabel?.text = "flag"
        } else {
            cell.buttonMore.titleLabel?.text = "picture"
        }
        cell.heartCount = viewModel[indexPath.row].saveCount ?? 0
        cell.isFlag = viewModel[indexPath.row].flag ?? true
        cell.postsIdx = viewModel[indexPath.row].pictureIdx
        cell.flagsIdx = viewModel[indexPath.row].flagIdx
        cell.preViewController = self
        return cell
    }
    
//    @objc func actionGoNextView(button: UIButton) {
//        let NextVC = DetailMessageViewController()
//        NextVC.flagIndex = button.tag
//        NextVC.type = button.titleLabel?.text ?? ""
//        NextVC.previousView = "Detail"
//        self.navigationController?.pushViewController(NextVC, animated: true)
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let comments = viewModel[indexPath.row].getCommentRes {
            let NextVC = DetailMessageViewController()
            if let tag = viewModel[indexPath.row].flagIdx {
                NextVC.flagIndex =  tag
            } else {
                NextVC.flagIndex = viewModel[indexPath.row].pictureIdx ?? 0
            }
            NextVC.previousView = "Profile"
            if viewModel[indexPath.row].flag ?? true {
                NextVC.type = "flag"
            } else {
                NextVC.type = "picture"
            }
            self.navigationController?.pushViewController(NextVC, animated: true)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let comments = viewModel[indexPath.row].getCommentRes {
            if comments.count == 0 {
                return CGSize(width: 341, height: 314)
            } else {
                return CGSize(width: 341, height: 386)
            }
        } else {
            return CGSize(width: 341, height: 314)
        }
    }
    
}

extension DetailUserViewController {
    func successDataApiPosts(_ result : DetailUserPostsResponse) {
        viewModel = result.getPostsRes ?? []
        collectionViewPost.reloadData()
    }
    func failureDataApiPosts(_ message : String) {
        self.presentAlert(title: message)
    }
}
