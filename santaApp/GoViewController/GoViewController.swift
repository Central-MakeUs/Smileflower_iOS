//
//  GoViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/06/29.
//

import UIKit

class GoViewController : BaseViewController, UISearchBarDelegate {
    let imageViewMountain = UIImageView()
    let imageViewHuman = UIImageView()
    let searchBar = UISearchBar()
    let labelWhere = UILabel()
    
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .titleColorGray
        return button
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.searchBar.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0xF1F7F9)
        navigationBarSet()
        imageViewSetBackground()
        labelSetWhere()
        searchBarSet()
    }
    // MARK: 네비게이션
    func navigationBarSet() {
        self.navigationItem.leftBarButtonItem = self.leftButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    @objc func actionBackButton(_ sender : Any) {
        self.changeRootViewController(BaseTabbarController())
    }
    // MARK: 배경화면
    func imageViewSetBackground() {
        imageViewMountain.image = UIImage(named: "mountain@3x")
        imageViewMountain.contentMode = .scaleAspectFill
        view.addSubview(imageViewMountain)
        
        imageViewMountain.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(664.9)
        }
        
        imageViewHuman.image = UIImage(named: "human@3x")
        imageViewHuman.contentMode = .center
        view.addSubview(imageViewHuman)
        
        imageViewHuman.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-266.6)
            make.leading.equalTo(view.snp.leading).offset(30.6)
            make.width.equalTo(237.4)
            make.height.equalTo(338)
        }
    }
    // MARK: 어느산으로 갈까요?
    func labelSetWhere() {
        labelWhere.text = "어느 산으로\n갈까요?"
        labelWhere.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 45)
        labelWhere.addCharacterSpacing(kernValue: -0.9)
        labelWhere.setTextWithLineHeight(text: labelWhere.text, lineHeight: 52)
        labelWhere.numberOfLines = 2
        view.addSubview(labelWhere)
        labelWhere.snp.makeConstraints { make in
            make.leading.equalTo(imageViewHuman.snp.leading)
            make.bottom.equalTo(imageViewHuman.snp.top)
        }
    }
    // MARK: 서치바
    func searchBarSet() {
        searchBar.delegate = self
        searchBar.placeholder = ""
        searchBar.layer.cornerRadius = 24
        searchBar.layer.masksToBounds = true
        searchBar.setImage(UIImage(named: "isCancel@3x"), for: .clear, state: .normal)
        searchBar.setTextFieldColor(.white, searchBar)
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-323.8)
            make.height.equalTo(48.5)
            make.width.equalTo(343)
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let mountainName = searchBar.text {
            print(mountainName)
            GoViewControllerDataManager().appflagsmountain(self, mountainName)
        }
    }
}

extension GoViewController {
    func successDataMountain(_ result : GoViewControllerEntityResult) {
        let nextVC = StartViewController()
        nextVC.mountainIdx = result.mountainIdx
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.labelMountainName.text = searchBar.text
        self.present(nextVC, animated: true, completion: nil)
    }
    func failureNoDataMountain(_ message : String) {
        self.presentAlert(title: message)
    }
}
