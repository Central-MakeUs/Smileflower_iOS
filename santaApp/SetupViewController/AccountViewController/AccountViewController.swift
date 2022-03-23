//
//  File.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/25.
//

import UIKit

class AccountViewController : BaseViewController {
    let arrayTitle : [String] = ["이메일", "탈퇴하기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSet()
        setTableView()
        resgisterTableView()
    }
    // MARK: 네비게이션 바
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .titleColorGray
        return button
    }()
    func navigationBarSet() {
        let height: CGFloat = 75
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self

        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = self.leftButton
        navbar.items = [navItem]
        navbar.topItem?.title = "계정"
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.layoutIfNeeded()
        view.addSubview(navbar)
    }
    @objc func actionBackButton(_ sender : Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: 계정 테이블 뷰 구현
    let tableViewContent = UITableView()
    func resgisterTableView() {
        tableViewContent.delegate = self
        tableViewContent.dataSource = self
        tableViewContent.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.identifier)
        tableViewContent.register(ResignTableViewCell.self, forCellReuseIdentifier: ResignTableViewCell.identifier)
    }
    func setTableView() {
        tableViewContent.backgroundColor = UIColor(hex: 0xf4f4f5)
        tableViewContent.separatorStyle = .none
        view.addSubview(tableViewContent)
        tableViewContent.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view)
            make.top.equalTo(view).offset(100)
        }
    }
}

extension AccountViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayTitle.count
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
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.identifier, for:indexPath)as?AccountTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            
            if let loginMethod = UserDefaults.standard.string(forKey: "loginMethod") {
                print(loginMethod)
                if loginMethod == "Kakao" {
                    cell.labelEmail.text = "카카오 로그인"
                } else if loginMethod == "Apple" {
                    cell.labelEmail.text = "애플 로그인"
                }
                else {
                   cell.labelEmail.text = loginMethod
               }
            }
             
            cell.selectionStyle = .none
            cell.labelTitle.text = arrayTitle[indexPath.section]
            cell.labelTitle.textColor = .darkbluegray
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ResignTableViewCell.identifier, for:indexPath) as? ResignTableViewCell
            else {
                fatalError("cant dequeue Cell")
                }
            cell.selectionStyle = .none
            cell.labelTitle.text = arrayTitle[indexPath.section]
            cell.labelTitle.textColor = .darkbluegray
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            showAlert(style: .alert)
        }
    }
    
    func showAlert(style: UIAlertController.Style) {
        let alert = UIAlertController(title: "정말 탈퇴하시겠습니까?", message: "탈퇴 시 60일 후 게시글들이 삭제됩니다. 바로 게시글이 삭제되는 것을 원하시면 직접 삭제 후 탈퇴해주세요!. 탈퇴 시 복구는 불가능합니다.", preferredStyle: style)
        let logout = UIAlertAction(title: "탈퇴하기", style: .default) { action in
            if let idx = Constant.userIdx {
                ResignDataManager().appuserslogout(self, userIdx: idx)
            }
        }
        logout.setValue(UIColor.red, forKey: "titleTextColor")
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        cancel.setValue(UIColor.darkbluegray, forKey: "titleTextColor")
        alert.addAction(logout)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension AccountViewController {
    func successResign() {
        let nextVC = LoginViewController()
        self.changeRootViewController(nextVC)
    }
}
