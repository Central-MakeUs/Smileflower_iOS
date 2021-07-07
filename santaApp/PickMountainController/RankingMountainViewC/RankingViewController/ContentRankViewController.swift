//
//  ContentRankViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/06.
//

import UIKit

class ContentRankViewController: UIViewController {

    let viewMaster = UIView()
    let viewSliver = UIView()
    let viewBronze = UIView()
    let tableViewRank = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setregister()
        viewSetRanker()
        tableViewSetRank()
    }
    func setregister() {
        tableViewRank.register(RankTableViewCell.self, forCellReuseIdentifier: RankTableViewCell.identifier)
        tableViewRank.register(MyRankTableViewCell.self, forCellReuseIdentifier: MyRankTableViewCell.identifier)
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
    func viewSetMaster() {
        let labelMasterTimes = UILabel()
        let imageViewMasterFlag = UIImageView()
        let labelMasterName = UILabel()
        let imageViewMasterProfileBack = UIImageView()
        let imageViewMaster = UIImageView()
        let imageViewMasterProfile = UIImageView()
        
        labelMasterTimes.text = "12회"
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
        labelMasterName.text = "코트"
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
    }
    //MARK: 2등
    func viewSetSliver() {
        let labelSliverTimes = UILabel()
        let imageViewMasterFlag = UIImageView()
        let labelSliverName = UILabel()
        let imageViewSliverProfileBack = UIImageView()
        let imageViewSliver = UIImageView()
        let imageViewSliverProfile = UIImageView()
        
        labelSliverTimes.text = "12회"
        labelSliverTimes.textAlignment = .right
        labelSliverTimes.textColor = .titleColorGray
        labelSliverTimes.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 12)
        viewSliver.addSubview(labelSliverTimes)
        labelSliverTimes.snp.makeConstraints { make in
            make.centerX.equalTo(viewSliver.snp.centerX).offset(-6.65)
            make.top.equalTo(viewSliver.snp.top).offset(0.5)
        }
        imageViewMasterFlag.image = UIImage(named: "FlagIconGray@3x")
        viewSliver.addSubview(imageViewMasterFlag)
        imageViewMasterFlag.snp.makeConstraints { make in
            make.leading.equalTo(labelSliverTimes.snp.trailing).offset(3.4)
            make.centerY.equalTo(labelSliverTimes.snp.centerY)
        }
        labelSliverName.text = "코트"
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
    }
    //MARK: 3등
    func viewSetBronze() {
        let labelBronzeTimes = UILabel()
        let imageViewMasterFlag = UIImageView()
        let labelBronzeName = UILabel()
        let imageViewBronzeProfileBack = UIImageView()
        let imageViewBronze = UIImageView()
        let imageViewBronzeProfile = UIImageView()
        
        labelBronzeTimes.text = "12회"
        labelBronzeTimes.textAlignment = .right
        labelBronzeTimes.textColor = .titleColorGray
        labelBronzeTimes.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 12)
        viewBronze.addSubview(labelBronzeTimes)
        labelBronzeTimes.snp.makeConstraints { make in
            make.centerX.equalTo(viewBronze.snp.centerX).offset(-6.65)
            make.top.equalTo(viewBronze.snp.top).offset(0.5)
        }
        imageViewMasterFlag.image = UIImage(named: "FlagIconGray@3x")
        viewBronze.addSubview(imageViewMasterFlag)
        imageViewMasterFlag.snp.makeConstraints { make in
            make.leading.equalTo(labelBronzeTimes.snp.trailing).offset(3.4)
            make.centerY.equalTo(labelBronzeTimes.snp.centerY)
        }
        labelBronzeName.text = "코트"
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
    }
    func tableViewSetRank() {
        tableViewRank.delegate = self
        tableViewRank.dataSource = self
        
        view.addSubview(tableViewRank)
        tableViewRank.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view)
            make.top.equalTo(viewMaster.snp.bottom).offset(37.8)
        }
    }
}

extension ContentRankViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRankTableViewCell.identifier, for: indexPath) as? MyRankTableViewCell
            else {
                fatalError("cant dequeue Cell")
            }
            
            cell.backgroundColor = .mainColor
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.tintColor = .white
            
            cell.labelRank.text = "2"
            
            cell.imageViewProfile.image = UIImage(named: "1083@3x")
            cell.imageViewProfile.backgroundColor = .white
            cell.imageViewProfile.contentMode = .scaleAspectFit
            cell.imageViewProfile.layer.cornerRadius = 18.5
            
            cell.labelUserLV.text = "Lv.10"
            
            cell.labelUserName.text = "산타"
            
            cell.labelUserlatest.text = "3일전"
            
            cell.labelUserTimes.text = "8회"
            
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RankTableViewCell.identifier, for: indexPath) as? RankTableViewCell
            else {
                fatalError("cant dequeue Cell")
            }
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.labelRank.text = String(indexPath.row + 3)
            
            cell.imageViewProfile.image = UIImage(named: "1083@3x")
            cell.imageViewProfile.contentMode = .scaleAspectFit
            cell.imageViewProfile.layer.cornerRadius = 18.5
            cell.imageViewProfile.layer.borderWidth = 0.2
            cell.imageViewProfile.layer.borderColor = UIColor.titleColorGray.cgColor
            
            cell.labelUserLV.text = "Lv.10"
            
            cell.labelUserName.text = "산타"
            
            cell.labelUserlatest.text = "3일전"
            
            cell.labelUserTimes.text = "8회"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 55
        }
        else {
            return 62
        }
    }
    
}
