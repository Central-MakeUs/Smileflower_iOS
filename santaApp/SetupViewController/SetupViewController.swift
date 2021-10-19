//
//  SetupViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import UIKit

class SetupViewController : BaseViewController {
    let arrayTitle : [String] = ["계정", "이용 약관"]
    var version: String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String as? String else {return nil}

        let versionAndBuild: String = "\(version)"
        return versionAndBuild
    }
         override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSet()
        resgisterTableView()
        setTableView()
    }
    //MARK: 네비게이션
    func navigationBarSet() {
        navigationItem.title = "설정"
    }
    //MARK: 설정 테이블 뷰 구현
    let tableViewContent = UITableView()
    func resgisterTableView() {
        tableViewContent.delegate = self
        tableViewContent.dataSource = self
        
        tableViewContent.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        tableViewContent.register(VersionTableViewCell.self, forCellReuseIdentifier: VersionTableViewCell.identifier)
        tableViewContent.register(LogoutTableViewCell.self, forCellReuseIdentifier: LogoutTableViewCell.identifier)
    }
    func setTableView() {
        tableViewContent.backgroundColor = UIColor(hex: 0xf4f4f5)
        tableViewContent.separatorStyle = .none
        view.addSubview(tableViewContent)
        tableViewContent.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    // MARK: 로그아웃 액션 시트
    func showAlert(style: UIAlertController.Style) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: style)
        let logout = UIAlertAction(title: "로그아웃", style: .default) { action in
            LogoutDataManager().appuserslogout(self)
            self.changeRootViewController(LoginViewController())
        }
        logout.setValue(UIColor.red, forKey: "titleTextColor")
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        cancel.setValue(UIColor.darkbluegray, forKey: "titleTextColor")
        alert.addAction(logout)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension SetupViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath)as? UserTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            cell.labelTitle.text = arrayTitle[indexPath.row]
            cell.layer.addBorder([.bottom], color: UIColor(hex: 0x7c909b, alpha: 0.2), width: 1)
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VersionTableViewCell.identifier, for: indexPath)as? VersionTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            cell.selectionStyle = .none
            cell.labelVersion.text = version
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LogoutTableViewCell.identifier, for: indexPath)as? LogoutTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            self.showAlert(style: .actionSheet)
        }
        else if indexPath.section == 0 {
            if indexPath.row == 0 {
                let nextVC = AccountViewController()
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            else {
                let nextVC = TermsOfServiceViewController()
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}
