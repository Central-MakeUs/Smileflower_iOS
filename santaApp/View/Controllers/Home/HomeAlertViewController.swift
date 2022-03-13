//
//  HomeAlertViewController.swift
//  santaApp
//
//  Created by 노영재 on 2022/03/01.
//

import UIKit

class HomeAlertViewController: BaseViewController {

    let viewModel = AlertViewModel()
    var arrayNotification : [AlertResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSet()
        setTableView()
        
        viewModel.appNewHomesNotification { result in
            self.arrayNotification = result
            self.tableViewAlert.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.popViewController(animated: false)
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
        navbar.backgroundColor = UIColor.clear
        navbar.delegate = self

        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = self.leftButton
        navbar.items = [navItem]
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.topItem?.title = "알림"
        navbar.layoutIfNeeded()
        view.addSubview(navbar)
    }
    @objc func actionBackButton(_ sender : Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    let tableViewAlert : UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    func setTableView() {
        
        tableViewAlert.delegate = self
        tableViewAlert.dataSource = self
        tableViewAlert.register(ShowAlertTableViewCell.self, forCellReuseIdentifier: ShowAlertTableViewCell.resueidentifier)
        view.addSubview(tableViewAlert)
        tableViewAlert.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(view).offset(90)
        }
    }
}

extension HomeAlertViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowAlertTableViewCell.resueidentifier, for: indexPath) as? ShowAlertTableViewCell else {
            return UITableViewCell()
        }
        
        cell.labelContent.text = arrayNotification[indexPath.row].type ?? ""
        cell.labelAgo.text = arrayNotification[indexPath.row].CreatedAt ?? ""
        
        if let status = arrayNotification[indexPath.row].status {
            if status == "T" {
                cell.contentView.backgroundColor = .white
                cell.imageViewProfile.backgroundColor = .iceblue
            } else {
                cell.contentView.backgroundColor = .iceblue
                cell.imageViewProfile.backgroundColor = .white
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idx = arrayNotification[indexPath.row].notificationIdx
        viewModel.appNewHomesNotificationIdx(idx) { result in
            if result == "" {
                self.presentAlert(title: "네트워크 오류")
            } else {
                self.viewModel.appNewHomesNotification { result in
                    self.arrayNotification = result
                    self.tableViewAlert.reloadData()
                }
            }
        }
    }
}
