//
//  TermsOfServiceViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/25.
//

import UIKit

class TermsOfServiceViewController : BaseViewController {
    let arrayTitle : [String] = ["이용 약관", "개인정보 처리 방침"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSet()
        setTableView()
        resgisterTableView()
    }
    
    func navigationBarSet() {
        self.navigationItem.title = "이용 약관"
    }
    //MARK: 이용약관 테이블 뷰 구현
    let tableViewContent = UITableView()
    func resgisterTableView() {
        tableViewContent.delegate = self
        tableViewContent.dataSource = self
        tableViewContent.register(TermsOfServiceTableViewCell.self, forCellReuseIdentifier: TermsOfServiceTableViewCell.identifier)
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

extension TermsOfServiceViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TermsOfServiceTableViewCell.identifier, for: indexPath)as?TermsOfServiceTableViewCell
        else {
            fatalError("cant dequeue Cell")
            }
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.labelTitle.text = arrayTitle[indexPath.row]
        cell.layer.addBorder([.bottom], color: UIColor(hex: 0x7c909b, alpha: 0.2), width: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let nextVC = TermsOfServiceDetailViewController()
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else {
            let nextVC = PrivacyUserDetailViewController()
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
