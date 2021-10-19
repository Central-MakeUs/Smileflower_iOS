//
//  ContentRankViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/06.
//

import UIKit
import Kingfisher

class ContentRankViewController: BaseViewController {

    let viewMaster = UIView()
    let viewSliver = UIView()
    let viewBronze = UIView()
    let tableViewRank = UITableView()
    var mountainIndex : Int?
    var mountainMyRank : MountainRankingMyRank?
    var mountainAllRank : [MountainRankingAllRank]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setregister()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        maskSilver.frame = imageViewSliverProfile.bounds
        maskMaster.frame = imageViewMasterProfile.bounds
        maskBronze.frame = imageViewBronzeProfile.bounds
    }
    func setregister() {
        tableViewRank.register(RankTableViewCell.self, forCellReuseIdentifier: RankTableViewCell.identifier)
    }
    // MARK: 랭커들 만들기
    func viewSetRanker() {
        view.addSubview(viewMaster)
        viewMaster.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(8)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(109)
            make.height.equalTo(161)
        }
        viewSetMaster()
        
        view.addSubview(viewSliver)
        viewSliver.snp.makeConstraints { make in
            make.trailing.equalTo(viewMaster.snp.leading).offset(5)
            make.top.equalTo(view.snp.top).offset(46)
            make.width.equalTo(105)
            make.height.equalTo(129)
        }
        viewSetSliver()
        view.addSubview(viewBronze)
        viewSetBronze()
        viewBronze.snp.makeConstraints { make in
            make.leading.equalTo(viewMaster.snp.trailing).offset(-5)
            make.top.equalTo(view.snp.top).offset(46)
            make.width.equalTo(105)
            make.height.equalTo(129)
        }
    }
    // MARK: 1등
    let labelMasterTimes = UILabel()
    let imageViewMasterFlag = UIImageView()
    let labelMasterName = UILabel()
    let imageViewMasterProfileBack = UIImageView()
    let imageViewMaster = UIImageView()
    let imageViewMasterProfile = UIImageView()
    let maskMaster = UIImageView()
    let buttonGoMaster = UIButton()
    
    func viewSetMaster() {
        if let allRank = mountainAllRank {
            buttonGoMaster.addTarget(self, action: #selector(actionGoMaster), for: .touchUpInside)
            viewMaster.addSubview(buttonGoMaster)
            buttonGoMaster.snp.makeConstraints { make in
                make.edges.equalTo(viewMaster)
            }
            buttonGoMaster.layer.zPosition = 333
            labelMasterTimes.text = "\(String(allRank[0].flagCount ?? 0))회"
            labelMasterTimes.textAlignment = .right
            labelMasterTimes.textColor = .titleColorGray
            labelMasterTimes.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 12)
            viewMaster.addSubview(labelMasterTimes)
            labelMasterTimes.snp.makeConstraints { make in
                make.centerX.equalTo(viewMaster.snp.centerX).offset(-6.65)
                make.top.equalTo(viewMaster.snp.top).offset(0.5)
            }
            imageViewMasterFlag.image = UIImage(named: "FlagIconGray@3x")
            viewMaster.addSubview(imageViewMasterFlag)
            imageViewMasterFlag.snp.makeConstraints { make in
                make.leading.equalTo(labelMasterTimes.snp.trailing).offset(3.4)
                make.centerY.equalTo(labelMasterTimes.snp.centerY)
            }
            labelMasterName.text = allRank[0].userName ?? "산타"
            labelMasterName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 18)
            labelMasterName.textAlignment = .center
            viewMaster.addSubview(labelMasterName)
            labelMasterName.snp.makeConstraints { make in
                make.centerX.equalTo(viewMaster.snp.centerX)
                make.top.equalTo(labelMasterTimes.snp.bottom)
                make.width.equalTo(105.4)
            }
            imageViewMasterProfileBack.image = UIImage(named: "masterView@3x")
            imageViewMasterProfileBack.contentMode = .scaleAspectFit
            viewMaster.addSubview(imageViewMasterProfileBack)
            imageViewMasterProfileBack.snp.makeConstraints { make in
                make.centerX.equalTo(viewMaster.snp.centerX)
                make.top.equalTo(labelMasterName.snp.bottom).offset(-15)
                make.width.equalTo(115.8)
                make.height.equalTo(146.2)
            }
            
            imageViewMasterProfile.contentMode = .scaleAspectFill
            imageViewMasterProfile.backgroundColor = .white
            if let urlString = allRank[0].userImage {
                print(urlString)
                let url = URL(string: urlString)
                imageViewMasterProfile.kf.indicatorType = .activity
                imageViewMasterProfile.kf.setImage(with: url)
            }
            else {
                imageViewMasterProfile.image = UIImage(named: "personhome@3x")
            }
            imageViewMasterProfileBack.addSubview(imageViewMasterProfile)
            imageViewMasterProfile.snp.makeConstraints { make in
                make.centerX.equalTo(imageViewMasterProfileBack)
                make.centerY.equalTo(imageViewMasterProfileBack).offset(-5)
                make.width.equalTo(62.7)
                make.height.equalTo(89)
            }
            maskMaster.image = UIImage(named: "mask@3x")
            imageViewMasterProfile.mask = maskMaster
            imageViewMaster.image = UIImage(named: "master@3x")
            imageViewMaster.contentMode = .scaleAspectFit
            imageViewMasterProfileBack.addSubview(imageViewMaster)
            imageViewMaster.snp.makeConstraints { make in
                make.centerX.equalTo(imageViewMasterProfileBack)
                make.centerY.equalTo(imageViewMasterProfileBack).offset(15)
                make.width.equalTo(80.4)
                make.height.equalTo(24.6)
            }
        }
        
    }
    @objc func actionGoMaster() {
        let nextVC = DetailAnotherUserViewController()
        if let allRank = mountainAllRank {
           let useridx = allRank[0].userIdx
            nextVC.userIdx = useridx
            nextVC.userName = allRank[0].userName
        }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
    //MARK: 2등
    let maskSilver = UIImageView()
    let labelSliverTimes = UILabel()
    let imageViewSliverFlag = UIImageView()
    let labelSliverName = UILabel()
    let imageViewSliverProfileBack = UIImageView()
    let imageViewSliver = UIImageView()
    let imageViewSliverProfile = UIImageView()
    let buttonGoSliver = UIButton()
    func viewSetSliver() {
        
        if let allRank = mountainAllRank {
            buttonGoSliver.addTarget(self, action: #selector(actionGoSilver), for: .touchUpInside)
            viewSliver.addSubview(buttonGoSliver)
            buttonGoSliver.snp.makeConstraints { make in
                make.edges.equalTo(viewSliver)
            }
            buttonGoSliver.layer.zPosition = 333
            
            labelSliverTimes.text = "\(String(allRank[1].flagCount!))회"
            labelSliverTimes.textAlignment = .right
            labelSliverTimes.textColor = .titleColorGray
            labelSliverTimes.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 12)
            viewSliver.addSubview(labelSliverTimes)
            labelSliverTimes.snp.makeConstraints { make in
                make.centerX.equalTo(viewSliver.snp.centerX).offset(-6.65)
                make.top.equalTo(viewSliver.snp.top).offset(0.5)
            }
            imageViewSliverFlag.image = UIImage(named: "FlagIconGray@3x")
            viewSliver.addSubview(imageViewSliverFlag)
            imageViewSliverFlag.snp.makeConstraints { make in
                make.leading.equalTo(labelSliverTimes.snp.trailing).offset(3.4)
                make.centerY.equalTo(labelSliverTimes.snp.centerY)
            }
            labelSliverName.text = allRank[1].userName
            labelSliverName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 18)
            labelSliverName.textAlignment = .center
            viewSliver.addSubview(labelSliverName)
            labelSliverName.snp.makeConstraints { make in
                make.centerX.equalTo(viewSliver.snp.centerX)
                make.top.equalTo(labelSliverTimes.snp.bottom)
                make.width.equalTo(105.4)
            }
            imageViewSliverProfileBack.image = UIImage(named: "silverView@3x")
            viewSliver.addSubview(imageViewSliverProfileBack)
            imageViewSliverProfileBack.snp.makeConstraints { make in
                make.centerX.equalTo(viewSliver.snp.centerX)
                make.top.equalTo(labelSliverName.snp.bottom).offset(-13.5)
                make.width.equalTo(107.5)
                make.height.equalTo(133.5)
            }
            imageViewSliverProfile.contentMode = .scaleAspectFill
            imageViewSliverProfile.backgroundColor = .white
            if let urlString = allRank[1].userImage {
                let url = URL(string: urlString)
                print(urlString)
                imageViewSliverProfile.kf.indicatorType = .activity
                imageViewSliverProfile.kf.setImage(with: url)
            }
            else {
                imageViewSliverProfile.image = UIImage(named: "personhome@3x")
            }
            imageViewSliverProfileBack.addSubview(imageViewSliverProfile)
            imageViewSliverProfile.snp.makeConstraints { make in
                make.centerX.equalTo(imageViewSliverProfileBack)
                make.centerY.equalTo(imageViewSliverProfileBack).offset(-5)
                make.width.equalTo(57.1)
                make.height.equalTo(80)
            }
            maskSilver.image = UIImage(named: "mask@3x")
            imageViewSliverProfile.mask = maskSilver
            imageViewSliver.image = UIImage(named: "sliver@3x")
            imageViewSliver.contentMode = .scaleAspectFit
            imageViewSliverProfileBack.addSubview(imageViewSliver)
            imageViewSliver.snp.makeConstraints { make in
                make.centerX.equalTo(imageViewSliverProfileBack)
                make.centerY.equalTo(imageViewSliverProfileBack).offset(15)
                make.width.equalTo(68.1)
                make.height.equalTo(19.6)
            }
        }
    }
    @objc func actionGoSilver() {
        let nextVC = DetailAnotherUserViewController()
        if let allRank = mountainAllRank {
           let useridx = allRank[1].userIdx
            nextVC.userIdx = useridx
            nextVC.userName = allRank[1].userName
        }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
    //MARK: 3등
    let labelBronzeTimes = UILabel()
    let imageViewBronzeFlag = UIImageView()
    let labelBronzeName = UILabel()
    let imageViewBronzeProfileBack = UIImageView()
    let imageViewBronze = UIImageView()
    let imageViewBronzeProfile = UIImageView()
    let maskBronze = UIImageView()
    let buttonGoBronze = UIButton()
    func viewSetBronze() {
        if let allRank = mountainAllRank {
            buttonGoBronze.addTarget(self, action: #selector(actionGoBronze), for: .touchUpInside)
            viewBronze.addSubview(buttonGoBronze)
            buttonGoBronze.snp.makeConstraints { make in
                make.edges.equalTo(viewBronze)
            }
            (buttonGoBronze).layer.zPosition = 333

            labelBronzeTimes.text = "\(String(allRank[2].flagCount!))회"
            labelBronzeTimes.textAlignment = .right
            labelBronzeTimes.textColor = .titleColorGray
            labelBronzeTimes.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 12)
            viewBronze.addSubview(labelBronzeTimes)
            labelBronzeTimes.snp.makeConstraints { make in
                make.centerX.equalTo(viewBronze.snp.centerX).offset(-6.65)
                make.top.equalTo(viewBronze.snp.top).offset(0.5)
            }
            imageViewBronzeFlag.image = UIImage(named: "FlagIconGray@3x")
            viewBronze.addSubview(imageViewBronzeFlag)
            imageViewBronzeFlag.snp.makeConstraints { make in
                make.leading.equalTo(labelBronzeTimes.snp.trailing).offset(3.4)
                make.centerY.equalTo(labelBronzeTimes.snp.centerY)
            }
            labelBronzeName.text = allRank[2].userName
            labelBronzeName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 18)
            labelBronzeName.textAlignment = .center
            viewBronze.addSubview(labelBronzeName)
            labelBronzeName.snp.makeConstraints { make in
                make.centerX.equalTo(viewBronze.snp.centerX)
                make.top.equalTo(labelBronzeTimes.snp.bottom)
                make.width.equalTo(105.4)
            }
            imageViewBronzeProfileBack.image = UIImage(named: "bronzeView@3x")
            viewBronze.addSubview(imageViewBronzeProfileBack)
            imageViewBronzeProfileBack.snp.makeConstraints { make in
                make.centerX.equalTo(viewBronze.snp.centerX)
                make.top.equalTo(labelBronzeName.snp.bottom).offset(-2)
                make.width.equalTo(87)
                make.height.equalTo(109.5)
            }
            imageViewBronzeProfile.contentMode = .scaleAspectFill
            imageViewBronzeProfile.backgroundColor = .white
            if let urlString = allRank[2].userImage {
                let url = URL(string: urlString)
                imageViewBronzeProfile.kf.indicatorType = .activity
                imageViewBronzeProfile.kf.setImage(with: url)
            }
            else {
                imageViewBronzeProfile.image = UIImage(named: "personhome@3x")
            }
            imageViewBronzeProfileBack.addSubview(imageViewBronzeProfile)
            imageViewBronzeProfile.snp.makeConstraints { make in
                make.centerX.equalTo(imageViewBronzeProfileBack).offset(1)
                make.centerY.equalTo(imageViewBronzeProfileBack).offset(-4)
                make.width.equalTo(57.1)
                make.height.equalTo(80)
            }
            maskBronze.image = UIImage(named: "mask@3x")
            imageViewBronzeProfile.mask = maskBronze
            imageViewBronze.image = UIImage(named: "bronze@3x")
            imageViewBronze.contentMode = .scaleAspectFit
            imageViewBronzeProfileBack.addSubview(imageViewBronze)
            imageViewBronze.snp.makeConstraints { make in
                make.centerX.equalTo(imageViewBronzeProfileBack)
                make.centerY.equalTo(imageViewBronzeProfileBack).offset(15)
                make.width.equalTo(68.1)
                make.height.equalTo(19.6)
            }
        }
        
    }
    @objc func actionGoBronze() {
        let nextVC = DetailAnotherUserViewController()
        if let allRank = mountainAllRank {
           let useridx = allRank[2].userIdx
            nextVC.userIdx = useridx
            nextVC.userName = allRank[2].userName
        }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
    //MARK: 테이블뷰
    func tableViewSetRank() {
        tableViewRank.delegate = self
        tableViewRank.dataSource = self
        tableViewRank.separatorStyle = .none
        view.addSubview(tableViewRank)
        tableViewRank.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view)
            make.top.equalTo(viewMyGrade.snp.bottom)
        }
        
        viewSetNonRank()
    }
    // MARK: 등수가 아무도 없을 때.
    let viewNonRank = UIView()
    let imageViewSmileFace = UIImageView()
    let labelExplain = UILabel()
    let labelExplainDetail = UILabel()
    
    func viewSetNonRank() {
        tableViewRank.addSubview(viewNonRank)
        viewNonRank.snp.makeConstraints { make in
            make.edges.equalTo(tableViewRank)
        }
        imageViewSmileFace.image = UIImage(named: "RankingFace@3x")
        imageViewSmileFace.contentMode = .scaleAspectFit
        viewNonRank.addSubview(imageViewSmileFace)
        imageViewSmileFace.snp.makeConstraints { make in
            make.top.equalTo(27.3)
            make.centerX.equalTo(tableViewRank)
            make.width.equalTo(39)
            make.height.equalTo(47.8)
        }
        labelExplain.textAlignment = .center
        labelExplain.text = "산을 정복해 경쟁에 참여하세요!"
        labelExplain.textColor = .bluegray
        labelExplain.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 24)
        viewNonRank.addSubview(labelExplain)
        labelExplain.snp.makeConstraints { make in
            make.top.equalTo(imageViewSmileFace.snp.bottom).offset(11)
            make.centerX.equalTo(imageViewSmileFace.snp.centerX)
        }
        
        labelExplainDetail.textAlignment = .center
        labelExplainDetail.text = "해당 산의 마스터가 될 수 있는 절호의 기회입니다!"
        labelExplainDetail.textColor = .bluegray
        labelExplainDetail.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 14)
        viewNonRank.addSubview(labelExplainDetail)
        labelExplainDetail.snp.makeConstraints { make in
            make.top.equalTo(labelExplain.snp.bottom).offset(3)
            make.centerX.equalTo(labelExplain.snp.centerX)
        }
    }
    //MARK: 내 등수
    let viewMyGrade = UIView()
    
    func setMyGrade() {
        viewMyGrade.backgroundColor = .mainColor
        view.addSubview(viewMyGrade)
        viewMyGrade.snp.makeConstraints { make in
            make.top.equalTo(viewMaster.snp.bottom).offset(37.8)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(55)
        }
        if let myRank = mountainMyRank {
            let labelRank = UILabel()
            labelRank.text = String(myRank.ranking!) 
            labelRank.textAlignment = .center
            labelRank.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 20)
            labelRank.textColor = .white
            viewMyGrade.addSubview(labelRank)
            labelRank.snp.makeConstraints { make in
                make.centerY.equalTo(viewMyGrade.snp.centerY)
                make.leading.equalTo(viewMyGrade.snp.leading).offset(16)
                make.width.equalTo(36)
                make.height.equalTo(17)
            }
            let imageViewProfile = UIImageView()
            imageViewProfile.contentMode = .scaleAspectFill
            imageViewProfile.clipsToBounds = true
            if let urlString = myRank.userImage {
                let url = URL(string: urlString)
                imageViewProfile.kf.setImage(with: url)
            }
            else {
                imageViewProfile.image = UIImage(named: "personhome@3x")
            }
            imageViewProfile.backgroundColor = .white
            imageViewProfile.layer.cornerRadius = 18.5
            viewMyGrade.addSubview(imageViewProfile)
            imageViewProfile.snp.makeConstraints { make in
                make.centerY.equalTo(labelRank.snp.centerY)
                make.leading.equalTo(labelRank.snp.trailing).offset(6)
                make.width.height.equalTo(37)
            }
            let labelUserLV = UILabel()
            labelUserLV.text = myRank.level ?? ""
            labelUserLV.textColor = .white
            labelUserLV.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 12)
            viewMyGrade.addSubview(labelUserLV)
            labelUserLV.snp.makeConstraints { make in
                make.leading.equalTo(imageViewProfile.snp.trailing).offset(18)
                make.top.equalTo(viewMyGrade.snp.top).offset(14)
            }
            let labelUserName = UILabel()
            labelUserName.text = myRank.userName
            labelUserName.textColor = .white
            labelUserName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 15)
            viewMyGrade.addSubview(labelUserName)
            labelUserName.snp.makeConstraints { make in
                make.leading.equalTo(labelUserLV.snp.leading)
                make.top.equalTo(labelUserLV.snp.bottom)
            }
            let labelUserTimes = UILabel()
            labelUserTimes.text = "\(String(myRank.flagCount!))회"
            labelUserTimes.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)
            labelUserTimes.textAlignment = .center
            labelUserTimes.textColor = .white
            viewMyGrade.addSubview(labelUserTimes)
            labelUserTimes.snp.makeConstraints { make in
                make.trailing.equalTo(viewMyGrade.snp.trailing).offset(-34.5)
                make.centerY.equalTo(labelUserName.snp.centerY)
                make.width.equalTo(43.5)
                make.height.equalTo(16)
            }
            let labelUserlatest = UILabel()
            labelUserlatest.text = myRank.agoTime
            labelUserlatest.textColor = .white
            labelUserlatest.textAlignment = .center
            labelUserlatest.layer.borderWidth = 0.5
            labelUserlatest.layer.borderColor = UIColor.white.cgColor
            labelUserlatest.layer.cornerRadius = 7
            labelUserlatest.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 11)
            viewMyGrade.addSubview(labelUserlatest)
            labelUserlatest.snp.makeConstraints { make in
                make.bottom.equalTo(labelUserTimes.snp.top).offset(-2.2)
                make.centerX.equalTo(labelUserTimes.snp.centerX)
                make.width.equalTo(37)
                make.height.equalTo(13)
            }
        }
        
        let buttonGoMyProfile = UIButton()
        buttonGoMyProfile.addTarget(self, action: #selector(actionGoMyProfile), for: .touchUpInside)
        viewMyGrade.addSubview(buttonGoMyProfile)
        buttonGoMyProfile.snp.makeConstraints { make in
            make.edges.equalTo(viewMyGrade)
        }
        let imageViewChevron = UIImageView()
        imageViewChevron.image = UIImage(systemName: "chevron.right")
        imageViewChevron.tintColor = .white
        viewMyGrade.addSubview(imageViewChevron)
        imageViewChevron.snp.makeConstraints { make in
            make.centerY.equalTo(viewMyGrade)
            make.trailing.equalTo(-16)
            make.width.equalTo(10)
            make.height.equalTo(15)
        }
    }
    @objc func actionGoMyProfile() {
        let nextVC = BaseTabbarController()
        nextVC.index = 3
        self.changeRootViewController(nextVC)
    }
}
// MARK: 테이블뷰 구현
extension ContentRankViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let allRank = mountainAllRank {
            if allRank.count == 3 {
                viewNonRank.alpha = 1
                return 0
            }
            else {
                viewNonRank.alpha = 0
                return allRank.count - 3
            }
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankTableViewCell.identifier, for: indexPath)as? RankTableViewCell
        else {
            fatalError("cant dequeue Cell")
            }
        if let allRank = mountainAllRank {
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.labelRank.text = String(indexPath.row + 4)

            if let urlString = allRank[indexPath.row + 3].userImage {
                let url = URL(string: urlString)
                cell.imageViewProfile.kf.setImage(with: url)
            }
            else {
                cell.imageViewProfile.image = UIImage(named: "personhome@3x")
            }
            cell.imageViewProfile.contentMode = .scaleAspectFit
            cell.imageViewProfile.layer.cornerRadius = 18.5
            cell.imageViewProfile.layer.borderWidth = 0.2
            cell.imageViewProfile.layer.borderColor = UIColor.titleColorGray.cgColor

            cell.labelUserLV.text = allRank[indexPath.row + 3].level

            cell.labelUserName.text = allRank[indexPath.row + 3].userName

            cell.labelUserlatest.text = allRank[indexPath.row + 3].agoTime

            cell.labelUserTimes.text = "\(String(allRank[indexPath.row + 3].flagCount ?? 0))회"
        }
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 55
        }
        else {
            return 62
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailAnotherUserViewController()
        if let allRank = mountainAllRank {
           let useridx = allRank[indexPath.row + 3].userIdx
            nextVC.userIdx = useridx
            nextVC.userName = allRank[indexPath.row + 3].userName
        }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
    
}
extension ContentRankViewController {
    func SuccessDataMountainRanking( _ result : MountainRankingResult) {
        mountainMyRank = result.myRank
        mountainAllRank = result.allRank
        viewSetRanker()
        setMyGrade()
        tableViewSetRank()
        tableViewRank.reloadData()
    }
    func failureDataMountainRanking( _ message : String ) {
        self.presentAlert(title: message)
    }
}
