//
//  File.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/25.
//

import UIKit

class AccountViewController : BaseViewController {
    let arrayTitle : [String] = ["이메일"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSet()
        setTableView()
        resgisterTableView()
    }
    func navigationBarSet() {
        self.navigationItem.title = "계정"
    }
    //MARK: 계정 테이블 뷰 구현
    let tableViewContent = UITableView()
    func resgisterTableView() {
        tableViewContent.delegate = self
        tableViewContent.dataSource = self
        tableViewContent.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.identifier)
    }
    func setTableView() {
        tableViewContent.backgroundColor = UIColor(hex: 0xf4f4f5)
        tableViewContent.separatorStyle = .none
        view.addSubview(tableViewContent)
        tableViewContent.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

extension AccountViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        }
        else {
            return 11
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.identifier, for:indexPath)as?AccountTableViewCell
        else {
            fatalError("cant dequeue Cell")
            }
        cell.labelEmail.text = Constant.userEmail ?? ""
        cell.selectionStyle = .none
        cell.labelTitle.text = arrayTitle[indexPath.section]
        cell.labelTitle.textColor = .darkbluegray
        return cell
    }
    
}
