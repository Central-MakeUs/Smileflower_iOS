//
//  ContentMountainViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/07.
//

import UIKit
import Kingfisher

class ContentMountainViewController: UIViewController {
    
    let contentTableView = UITableView()
    var mountainIdx : Int?
    
    var mountainInfoResult : MountainInfoInfo?
    var mountainRoadResult : [MountainInfoRoad] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
    }

    //MARK: 테이블뷰 등록
    func registerTableView() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.separatorStyle = .none

        contentTableView.register(MountainImageTableViewCell.self, forCellReuseIdentifier: MountainImageTableViewCell.identifier)
        contentTableView.register(MountainPositionTableViewCell.self, forCellReuseIdentifier: MountainPositionTableViewCell.identifier)
        contentTableView.register(MountainHeightTableViewCell.self, forCellReuseIdentifier: MountainHeightTableViewCell.identifier)
        contentTableView.register(MountainCourseTableViewCell.self, forCellReuseIdentifier: MountainCourseTableViewCell.identifier)

        view.addSubview(contentTableView)
        contentTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ContentMountainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MARK: 산 사진, 이름, 찜하기 셀
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MountainImageTableViewCell.identifier, for: indexPath)as? MountainImageTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            if let idx = mountainIdx {
                cell.mountainIdx = idx
            }
            cell.selectionStyle = .none
            if let mountaininfo = mountainInfoResult {
                cell.labelMountainName.text = mountaininfo.mountainName
                if let urlString = mountaininfo.mountainImg {
                    let url = URL(string: urlString)
                    let proccess = DownsamplingImageProcessor(size: cell.imageViewMountain.bounds.size)
                    cell.imageViewMountain.kf.setImage(with: url , options: [.processor(proccess)])
                }
                if mountaininfo.pick == "T" {
                    cell.buttonLike.isSelected = true
                }
                if mountaininfo.hot == "인기" {
                    cell.imageViewHotMountain.image = UIImage(named: "icInfoHot@3x")
                }
                else {
                    cell.imageViewHotMountain.image = UIImage()
                }
                switch mountaininfo.difficulty {
                case 1:
                    cell.imageViewMountainDifficulty.image = UIImage(named: "illustInfo1@3x")
                case 2:
                    cell.imageViewMountainDifficulty.image = UIImage(named: "illustInfo2@3x")
                case 3:
                    cell.imageViewMountainDifficulty.image = UIImage(named: "illustInfo3@3x")
                case 4:
                    cell.imageViewMountainDifficulty.image = UIImage(named: "illustInfo4@3x")
                case 5:
                    cell.imageViewMountainDifficulty.image = UIImage(named: "illustInfo5@3x")
                default:
                    print("오류")
                }
            }
            return cell
        }
        //MAKR: 산 위치 셀
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MountainPositionTableViewCell.identifier, for: indexPath)as? MountainPositionTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            cell.selectionStyle = .none
            if let mountianInfo = mountainInfoResult {
                cell.labelMountainAddress.text = mountianInfo.address
            }
            return cell
        }
        //MARK: 산 높이 셀
        else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MountainHeightTableViewCell.identifier, for: indexPath)as? MountainHeightTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            cell.selectionStyle = .none
            if let mountianInfo = mountainInfoResult {
                cell.labelHeightConstant.text = mountianInfo.high
            }
            return cell
        }
        //MARK: 코스 셀
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MountainCourseTableViewCell.identifier, for: indexPath)as? MountainCourseTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            cell.courseArray = mountainRoadResult
            cell.tableViewCourse.reloadData()
            cell.isSelected = false
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 197
        }
        else if indexPath.row == 1 {
            return 57
        }
        else if indexPath.row == 2 {
            return 38
        }
        else if indexPath.row == 3 {
            let numOfCourse = CGFloat(mountainRoadResult.count)
            return 26 * numOfCourse + 6 * numOfCourse + 150
        }
        else {
            return 500
        }
    }
}
extension ContentMountainViewController {
    func successDataMountainInfo(_ result : MountainInfoResult) {
        mountainInfoResult = result.info
        if let Course = result.road {
            mountainRoadResult = Course
        }
        contentTableView.reloadData()
    }
    func faillureDataMountainInfo(_ message : String) {
        self.presentAlert(title: message)
    }
}
