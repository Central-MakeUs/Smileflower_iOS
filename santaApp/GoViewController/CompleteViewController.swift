//
//  CompleteViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/02.
//

import UIKit
import Kingfisher

class CompleteViewController : BaseViewController, UINavigationBarDelegate  {
    let imageViewComplete = UIImageView()
    let buttonGoConquerMountainView = UIButton()
    let viewRank = UIView()
    let viewMaster = UIView()
    let imageViewBackground = UIImageView()
    var mountainIdx : Int?
    
    var myRankResult : CompleteConqueredMyRank?
    var firstRankResult : CompleteConqueredFirstRank?
    
    // MARK: 최하단 랭킹 뷰 변수들
    let labelRankTitle = UILabel()
    let stackViewRackView = UIStackView()
    let viewMasterRankView = UIView()
    let viewUserRankView = UIView()
    
    let labelMasterRank = UILabel()
    let labelUserRank = UILabel()
    
    let imageViewMasterRank = UIImageView()
    let imageViewUserRank = UIImageView()
    
    let imageViewMasterProfile = UIImageView()
    let imageViewUserProfile = UIImageView()
    
    let labelMasterLV = UILabel()
    let labelUserLV = UILabel()
    
    let labelMasterName = UILabel()
    let labelUserName = UILabel()
    
    let labelMasterTimes = UILabel()
    let labelUsertimes = UILabel()
    
    let imageViewFlag = UIImageView()
    let imageViewFlag2 = UIImageView()
    
    
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .white
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let idx = mountainIdx {
            CompleteConqueredDataManager().appflagsmountainIdxrank(self, idx)
        }
        view.setGradient(color1: UIColor(hex: 0x9ac7ff), color2: UIColor(hex: 0xffffff))
        navigationBarSet()
        imageViewSetBackground()
        buttonSetGoConquerMountainView()
        imageViewSetComplete()
        viewSetRank()
        viewSetRankingView()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.setFirstAnimation()
    }
    // MARK: 네비게이션 바
    func navigationBarSet() {
        let height: CGFloat = 75
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.clear
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
        self.changeRootViewController(BaseTabbarController())
    }
    // MARK: 배경
    let imageViewConqueredPerson = UIImageView()
    func imageViewSetBackground() {
    
        imageViewBackground.image = UIImage(named: "ConquerBack@3x")
        let firstFrame = CGRect(x: UIScreen.main.bounds.width/2 - 1032 + 238, y: -224, width: 2064, height: 1220)
        imageViewBackground.frame = firstFrame
        imageViewBackground.contentMode = .scaleAspectFit
        view.addSubview(imageViewBackground)
        
        imageViewConqueredPerson.image = UIImage(named: "ConquerImage@3x")
        imageViewConqueredPerson.frame = CGRect(x: UIScreen.main.bounds.width/2 - 54, y: 145.8, width: 0, height: 0)
        imageViewConqueredPerson.contentMode = .scaleAspectFit
        view.addSubview(imageViewConqueredPerson)
    }
    func setFirstAnimation() {
        UIView.animate(withDuration: 2.0) {
            let secondFrame = CGRect(x: UIScreen.main.bounds.width/2 - 1032 + 238, y: 233, width: 2064, height: 1220)
            self.imageViewBackground.frame = secondFrame
        } completion: { finished in
            self.setSecondAnimation()
        }
        
    }
    func setSecondAnimation() {
        UIView.animate(withDuration: 0.5) {
            switch Constant.userPhoneHeight {
            // 아이폰 6
                case 667:
                    let thirdFrame = CGRect(x: UIScreen.main.bounds.width/2 - 470 + 95 - 79 , y: 141.4, width: 920, height: 373.6)
                    self.imageViewBackground.frame = thirdFrame
            // 아이폰 8 플러스
                case 736:
                    let thirdFrame = CGRect(x: UIScreen.main.bounds.width/2 - 470 + 95 - 74 , y: 171.4, width: 920, height: 403.6)
                    self.imageViewBackground.frame = thirdFrame
                case 812:
                    let thirdFrame = CGRect(x: UIScreen.main.bounds.width/2 - 470 + 95 - 63 , y: 177.7, width: 920, height: 484.7)
                    self.imageViewBackground.frame = thirdFrame
            // 아이폰 12
                case 844:
                    let thirdFrame = CGRect(x: UIScreen.main.bounds.width/2 - 470 + 95 - 58 , y: 191.7, width: 920, height: 504.7)
                    self.imageViewBackground.frame = thirdFrame
            // 아이폰 11
                case 896:
                    let thirdFrame = CGRect(x: UIScreen.main.bounds.width/2 - 470 + 95 - 58 , y: 232.3, width: 920, height: 524.7)
                    self.imageViewBackground.frame = thirdFrame
            // 아이폰 12 프로 플러스
                case 926:
                    let thirdFrame = CGRect(x: UIScreen.main.bounds.width/2 - 470 + 95 - 50 , y: 222.6, width: 920, height: 584.7)
                    self.imageViewBackground.frame = thirdFrame
                default:
                    let thirdFrame = CGRect(x: UIScreen.main.bounds.width/2 - 470 + 95 - 50 , y: 222.6, width: 920, height: 584.7)
                    self.imageViewBackground.frame = thirdFrame
            }

            
        } completion: { finished in
            self.setThirdAnimation()
        }
    }
    func setThirdAnimation() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            switch Constant.userPhoneHeight {
            // 아이폰 6
                case 667:
                    self.imageViewConqueredPerson.frame = CGRect(x: UIScreen.main.bounds.width/2 - 54, y: 61, width: 153.7, height: 143.7)
                    self.imageViewComplete.frame = CGRect(x: UIScreen.main.bounds.width/2 - 104.15, y: UIScreen.main.bounds.height/2 - 46.95, width: 208.3, height: 93.9)
            // 아이폰 8 플러스
                case 736:
                    self.imageViewConqueredPerson.frame = CGRect(x: UIScreen.main.bounds.width/2 - 54, y: 91, width: 153.7, height: 143.7)
                    self.imageViewComplete.frame = CGRect(x: UIScreen.main.bounds.width/2 - 130.65, y: 280.7, width: 261.3, height: 116.8)
                case 812:
                    self.imageViewConqueredPerson.frame = CGRect(x: UIScreen.main.bounds.width/2 - 54, y: 77.7, width: 191.2, height: 178.7)
                    self.imageViewComplete.frame = CGRect(x: UIScreen.main.bounds.width/2 - 130.65, y: 356.5, width: 261.3, height: 116.9)
            // 아이폰 12
                case 844:
                    self.imageViewConqueredPerson.frame = CGRect(x: 146.6, y: 52, width: 191, height: 178)
                    self.imageViewComplete.frame = CGRect(x: UIScreen.main.bounds.width/2 - 130.65, y: UIScreen.main.bounds.height/2 - 58.4, width: 261.3, height: 116.8)
            // 아이폰 11
                case 896:
                    self.imageViewConqueredPerson.frame = CGRect(x: UIScreen.main.bounds.width/2 - 54, y: 132.3, width: 191.2, height: 178.7)
                    self.imageViewComplete.frame = CGRect(x: UIScreen.main.bounds.width/2 - 130.65, y: 440.5, width: 261.3, height: 116.9)
            // 아이폰 12 프로 플러스
                case 926:
                    self.imageViewConqueredPerson.frame = CGRect(x: UIScreen.main.bounds.width/2 - 54, y: 114, width: 207.6, height: 194)
                    self.imageViewComplete.frame = CGRect(x: UIScreen.main.bounds.width/2 - 141.4, y: 457.5, width: 282.8, height: 126.5)
                default:
                    self.imageViewConqueredPerson.frame = CGRect(x: UIScreen.main.bounds.width/2 - 54, y: 114, width: 207.6, height: 194)
                    self.imageViewComplete.frame = CGRect(x: UIScreen.main.bounds.width/2 - 141.4, y: 457.5, width: 282.8, height: 126.5)
            }

            
        }, completion: nil)
    }
    // MARK: 정복 이미지
    func imageViewSetComplete() {
        imageViewComplete.image = UIImage(named: "completeMountain")
        imageViewComplete.contentMode = .scaleAspectFill
        view.addSubview(imageViewComplete)
        imageViewComplete.frame = CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2, width: 0, height: 0)
    }
    // MARK: 내가 정복한 산 보러가기
    func buttonSetGoConquerMountainView() {
        buttonGoConquerMountainView.setTitle("내가 정복한 산 보러가기", for: .normal)
        buttonGoConquerMountainView.backgroundColor = UIColor(hex: 0x1C3240)
        buttonGoConquerMountainView.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 16)
        buttonGoConquerMountainView.addTarget(self, action: #selector(actionGoConquerMountainView), for: .touchUpInside)
        view.addSubview(buttonGoConquerMountainView)

        switch Constant.userPhoneHeight {
        // 아이폰 6
            case 667:
                buttonGoConquerMountainView.snp.makeConstraints { make in
                    make.centerX.equalTo(view.snp.centerX)
                    make.width.equalTo(237)
                    make.height.equalTo(50)
                    make.top.equalTo(view).offset(350)
                }
        // 아이폰 8 플러스
            case 736:
                buttonGoConquerMountainView.snp.makeConstraints { make in
                    make.centerX.equalTo(view.snp.centerX)
                    make.width.equalTo(237)
                    make.height.equalTo(50)
                    make.top.equalTo(view).offset(413)
                }
        // 아이폰 11 pro
            case 812:
                buttonGoConquerMountainView.snp.makeConstraints { make in
                    make.centerX.equalTo(view.snp.centerX)
                    make.width.equalTo(237)
                    make.height.equalTo(50)
                    make.top.equalTo(view).offset(488.8)
                }
        // 아이폰 12
            case 844:
                buttonGoConquerMountainView.snp.makeConstraints { make in
                    make.centerX.equalTo(view.snp.centerX)
                    make.width.equalTo(237)
                    make.height.equalTo(50)
                    make.top.equalTo(view).offset(520.8)
                }
        // 아이폰 11
            case 896:
                buttonGoConquerMountainView.snp.makeConstraints { make in
                    make.centerX.equalTo(view.snp.centerX)
                    make.width.equalTo(237)
                    make.height.equalTo(50)
                    make.top.equalTo(view).offset(572.8)
                }
        // 아이폰 12 프로 플러스
            case 926:
                buttonGoConquerMountainView.snp.makeConstraints { make in
                    make.centerX.equalTo(view.snp.centerX)
                    make.width.equalTo(237)
                    make.height.equalTo(50)
                    make.top.equalTo(view).offset(600)
                }
            default:
                buttonGoConquerMountainView.snp.makeConstraints { make in
                    make.centerX.equalTo(view.snp.centerX)
                    make.width.equalTo(237)
                    make.height.equalTo(50)
                    make.top.equalTo(view).offset(600)
                }
        }
       
        buttonGoConquerMountainView.layer.cornerRadius = 25
    }
    @objc func actionGoConquerMountainView() {
        let nextVC = FlagMapViewController()
        nextVC.useridx = myRankResult?.userIdx
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
    
    // MARK: 최하단 랭킹 뷰
    func viewSetRank() {
        viewRank.roundCorners(cornerRadius: 28, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        viewRank.layer.shadowColor = UIColor(hex: 0x808CA0).cgColor
        viewRank.layer.shadowOpacity = 0.3
        viewRank.layer.shadowOffset = CGSize(width: 0, height: 8)
        viewRank.layer.shadowRadius = 0
        viewRank.backgroundColor = .white
        view.addSubview(viewRank)
        
        viewRank.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(244)
        }
    }
    // MARK: 랭킹 마스터 뷰
    func viewSetRankingView() {
        
        labelRankTitle.text = "랭킹"
        labelRankTitle.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)
        labelRankTitle.textAlignment = .center
        labelRankTitle.textColor = UIColor.darkbluegray
        viewRank.addSubview(labelRankTitle)
        
        labelRankTitle.snp.makeConstraints { make in
            make.centerX.equalTo(viewRank.snp.centerX)
            make.top.equalTo(viewRank.snp.top).offset(17)
        }
        setRankingTableView()
    }
    let tableViewRanking = UITableView()
    func setRankingTableView() {
        tableViewRanking.delegate = self
        tableViewRanking.dataSource = self
        tableViewRanking.register(RankingTableViewCell.self, forCellReuseIdentifier: RankingTableViewCell.resueidentifier)
        tableViewRanking.register(MyRankingTableViewCell.self, forCellReuseIdentifier: MyRankingTableViewCell.resueidentifier)
        tableViewRanking.isScrollEnabled = false
        tableViewRanking.separatorColor = UIColor(hex: 0x7C909B, alpha: 0.5)
        viewRank.addSubview(tableViewRanking)
        tableViewRanking.snp.makeConstraints { make in
            make.top.equalTo(labelRankTitle.snp.bottom)
            make.leading.trailing.equalTo(viewRank)
            make.bottom.equalTo(-20)
        }
    }
}
extension CompleteViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingTableViewCell.resueidentifier, for: indexPath)as? RankingTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            if let ranking = firstRankResult?.ranking,
               let username = firstRankResult?.userName,
               let userLv = firstRankResult?.level,
               let flagCount = firstRankResult?.flagCount{
                cell.labelRank.text = String(ranking)
                cell.imageViewUserProfile.image = UIImage(named: "masterView@3x")
                cell.imageViewUserGrade.image = UIImage(named: "master@3x")
                cell.imageViewUserProfile.snp.makeConstraints { make in
                    make.centerY.equalTo(cell.contentView)
                    make.leading.equalTo(cell.labelRank.snp.trailing).offset(2.5)
                    make.width.equalTo(82.9)
                    make.height.equalTo(103)
                }
                if let urlString = firstRankResult?.userImage {
                    let url = URL(string: urlString)
                    let proceesor = DownsamplingImageProcessor(size: cell.imageViewUser.bounds.size)
                    cell.imageViewUser.kf.setImage(with: url, options: [.processor(proceesor)])
                }
                else {
                    cell.imageViewUser.image = UIImage(named: "personhome@3x")
                }
                cell.labelUserLv.text = userLv
                cell.imageViewUser.backgroundColor = .white
                cell.imagemask.frame = cell.imageViewUser.bounds
                cell.labelUserName.text = username
                cell.labelConquered.text = "\(String(flagCount))회"
            }
            cell.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
            cell.selectionStyle = .none
            return cell
        }
        
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRankingTableViewCell.resueidentifier, for: indexPath)as? MyRankingTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            if let ranking = self.myRankResult?.ranking,
               let username = self.myRankResult?.userName,
               let userLv = self.myRankResult?.level,
               let flagCount = self.myRankResult?.flagCount{
                cell.labelRank.text = String(ranking)
                cell.imageViewUserProfile.image = UIImage(named: "946@3x")
                cell.imageViewUserProfile.snp.makeConstraints { make in
                    make.centerY.equalTo(cell.contentView)
                    make.leading.equalTo(cell.labelRank.snp.trailing).offset(10.7)
                    make.width.equalTo(70)
                    make.height.equalTo(90)
                }
                if let urlString = myRankResult?.userImage {
                    let url = URL(string: urlString)
                    let proceesor = DownsamplingImageProcessor(size: cell.imageViewUser.bounds.size)
                    cell.imageViewUser.kf.setImage(with: url, options: [.processor(proceesor)])
                }
                else {
                    cell.imageViewUser.image = UIImage(named: "personhome@3x")
                }
                
                cell.labelUserLv.text = userLv
                cell.imageViewUser.backgroundColor = .white
                
                cell.imagemask.frame = cell.imageViewUser.bounds
                cell.labelUserName.text = username
                cell.labelConquered.text = "\(String(flagCount))회"
            }
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
            return cell
        }
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewRanking.bounds.height/2 - 10
    }
}

extension CompleteViewController {
    func successDataResult( _ result : CompleteConqueredResult) {
        myRankResult = result.myRank!
        firstRankResult = result.firstRank!
        tableViewRanking.reloadData()
    }
    func failureDataResutl() {
        self.presentAlert(title: "네트워크 통신 장애")
    }
}
