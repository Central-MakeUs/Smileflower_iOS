//
//  ContentMountainViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/07.
//

import UIKit

class ContentMountainViewController: UIViewController {
    
    let contentTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
    }
    //MARK: 테이블뷰 등록
    func registerTableView() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.separatorStyle = .none
        contentTableView.estimatedRowHeight = 38
        contentTableView.rowHeight = UITableView.automaticDimension
        contentTableView.register(MountainImageTableViewCell.self, forCellReuseIdentifier: MountainImageTableViewCell.identifier)
        contentTableView.register(MountainPositionTableViewCell.self, forCellReuseIdentifier: MountainPositionTableViewCell.identifier)
        contentTableView.register(MountainHeightTableViewCell.self, forCellReuseIdentifier: MountainHeightTableViewCell.identifier)
        contentTableView.register(MountainCourseTableViewCell.self, forCellReuseIdentifier: MountainCourseTableViewCell.identifier)
        contentTableView.register(WarningTableViewCell.self, forCellReuseIdentifier: WarningTableViewCell.identifier)

        view.addSubview(contentTableView)
        contentTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ContentMountainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MountainImageTableViewCell.identifier, for: indexPath)as? MountainImageTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MountainPositionTableViewCell.identifier, for: indexPath)as? MountainPositionTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MountainHeightTableViewCell.identifier, for: indexPath)as? MountainHeightTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MountainCourseTableViewCell.identifier, for: indexPath)as? MountainCourseTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
//            cell.selectionStyle = .none
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WarningTableViewCell.identifier, for: indexPath) as? WarningTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
//            cell.selectionStyle = .none
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
            return 26 * 5 + 6 * 7 + 22
        }
        else {
            return 700
        }
    }
}
