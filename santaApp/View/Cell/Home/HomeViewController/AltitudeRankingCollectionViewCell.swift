//
//  AltitudeRankingCollectionViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/12/22.
//

import UIKit

class AltitudeRankingCollectionViewCell: UICollectionViewCell {
    static let resueidentifier = "AltitudeRankingCollectionViewCell"
    var arrayUser : [HomeModelUserList] = []
    
    var cellIndex : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let tableViewContent : UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    func setTableView() {
        tableViewContent.delegate = self
        tableViewContent.dataSource = self
        tableViewContent.register(AltitudeRankingTableViewCell.self, forCellReuseIdentifier: AltitudeRankingTableViewCell.resueidentifier)
        
        self.addSubview(tableViewContent)
        tableViewContent.snp.makeConstraints { make in
            make.top.equalTo(self).offset(25)
            make.bottom.equalTo(self).offset(-20)
            make.trailing.leading.equalTo(self)
        }
    }
}

extension AltitudeRankingCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayUser.count == 0 {
            return 0
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AltitudeRankingTableViewCell.resueidentifier, for: indexPath) as? AltitudeRankingTableViewCell else {
            return UITableViewCell()
        }
        print(cellIndex)
        if cellIndex == 0 {
            cell.labelGrade.text = String(indexPath.row + 1)
            switch indexPath.row {
            case 0:
                cell.imageViewTopGrade.image = UIImage(named: "illustHomeTop1")
            case 1:
                cell.imageViewTopGrade.image = UIImage(named: "illustHomeTop2")
            case 2:
                cell.imageViewTopGrade.image = UIImage(named: "illustHomeTop3")
            default:
                print("pass")
            }
            cell.labelUserLv.text = arrayUser[indexPath.row].level
            cell.labelUserNickName.text = arrayUser[indexPath.row].userName
            cell.labelConquerAgo.text = arrayUser[indexPath.row].agoTime
            cell.labelMountainHeight.text = arrayUser[indexPath.row].height
            if let urlString = arrayUser[indexPath.row].userImageUrl {
                let url = URL(string: urlString)
                cell.imageViewUserImage.kf.indicatorType = .activity
                cell.imageViewUserImage.kf.setImage(with: url)
            } else {
                cell.imageViewUserImage.image = UIImage(named: "personhome")
            }
        } else {
            cell.labelGrade.text = String(indexPath.row + 5)
            cell.labelUserLv.text = arrayUser[indexPath.row + 5].level
            cell.labelUserNickName.text = arrayUser[indexPath.row + 5].userName
            cell.labelConquerAgo.text = arrayUser[indexPath.row + 5].agoTime
            cell.labelMountainHeight.text = arrayUser[indexPath.row + 5].height
            
            if let urlString = arrayUser[indexPath.row + 5].userImageUrl {
                let url = URL(string: urlString)
                cell.imageViewUserImage.kf.indicatorType = .activity
                cell.imageViewUserImage.kf.setImage(with: url)
            } else {
                cell.imageViewUserImage.image = UIImage(named: "personhome")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
