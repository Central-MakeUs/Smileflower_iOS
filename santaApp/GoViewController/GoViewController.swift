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
        
        imageViewHuman.image = UIImage(named: "human@3x")
        imageViewHuman.contentMode = .center
        view.addSubview(imageViewHuman)
        
        switch Constant.userPhoneHeight {
            case 667:
                imageViewMountain.snp.makeConstraints { make in
                    make.leading.bottom.trailing.equalTo(view)
                    make.top.equalTo(view.snp.top).offset(96)
                }
                imageViewHuman.snp.makeConstraints { make in
                    make.bottom.equalTo(view.snp.bottom).offset(-154.7)
                    make.leading.equalTo(view.snp.leading).offset(30.4)
                    make.width.equalTo(224.8)
                    make.height.equalTo(320.1)
                }
            case 736:
                imageViewMountain.snp.makeConstraints { make in
                    make.leading.bottom.trailing.equalTo(view)
                    make.top.equalTo(view.snp.top).offset(135.6)
                }
                imageViewHuman.snp.makeConstraints { make in
                    make.bottom.equalTo(view.snp.bottom).offset(-202.1)
                    make.leading.equalTo(view.snp.leading).offset(41.1)
                    make.width.equalTo(237.4)
                    make.height.equalTo(338)
                }
            case 812:
                imageViewMountain.snp.makeConstraints { make in
                    make.leading.bottom.trailing.equalTo(view)
                    make.top.equalTo(view.snp.top).offset(151.8)
                }
                imageViewHuman.snp.makeConstraints { make in
                    make.bottom.equalTo(view.snp.bottom).offset(-266.6)
                    make.leading.equalTo(view.snp.leading).offset(30.6)
                    make.width.equalTo(237.4)
                    make.height.equalTo(338)
                }
            case 844:
                imageViewMountain.snp.makeConstraints { make in
                    make.leading.bottom.trailing.equalTo(view)
                    make.top.equalTo(view.snp.top).offset(167.4)
                }
                imageViewHuman.snp.makeConstraints { make in
                    make.bottom.equalTo(view.snp.bottom).offset(-278.3)
                    make.leading.equalTo(view.snp.leading).offset(30.6)
                    make.width.equalTo(237.4)
                    make.height.equalTo(338)
                }
            case 896:
                imageViewMountain.snp.makeConstraints { make in
                    make.leading.bottom.trailing.equalTo(view)
                    make.top.equalTo(view.snp.top).offset(172.3)
                }
                imageViewHuman.snp.makeConstraints { make in
                    make.bottom.equalTo(view.snp.bottom).offset(-291.3)
                    make.leading.equalTo(view.snp.leading).offset(37.7)
                    make.width.equalTo(257.5)
                    make.height.equalTo(366.6)
                }
            case 926:
                imageViewMountain.snp.makeConstraints { make in
                    make.leading.bottom.trailing.equalTo(view)
                    make.top.equalTo(view.snp.top).offset(172.3)
                }
                imageViewHuman.snp.makeConstraints { make in
                    make.bottom.equalTo(view.snp.bottom).offset(-301.7)
                    make.leading.equalTo(view.snp.leading).offset(37.7)
                    make.width.equalTo(257.5)
                    make.height.equalTo(366.6)
                }
            default:
                imageViewMountain.snp.makeConstraints { make in
                    make.leading.bottom.trailing.equalToSuperview()
                    make.height.equalTo(664.9)
                }
                imageViewHuman.snp.makeConstraints { make in
                    make.bottom.equalTo(view.snp.bottom).offset(-266.6)
                    make.leading.equalTo(view.snp.leading).offset(30.6)
                    make.width.equalTo(237.4)
                    make.height.equalTo(338)
                }
        }
    }
    // MARK: 어느산으로 갈까요?
    func labelSetWhere() {
        labelWhere.text = "어느 산으로\n갈까요?"
        
        labelWhere.numberOfLines = 2
        view.addSubview(labelWhere)
        
        switch Constant.userPhoneHeight {
            case 667:
                labelWhere.snp.makeConstraints { make in
                    labelWhere.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 42)
                    labelWhere.addCharacterSpacing(kernValue: -0.84)
                    labelWhere.setTextWithLineHeight(text: labelWhere.text, lineHeight: 49)
                    
                    make.leading.equalTo(view.snp.leading).offset(33.1)
                    make.top.equalTo(view.snp.top).offset(96)
                }
            case 736:
                labelWhere.snp.makeConstraints { make in
                    labelWhere.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 45)
                    labelWhere.addCharacterSpacing(kernValue: -0.9)
                    labelWhere.setTextWithLineHeight(text: labelWhere.text, lineHeight: 52)

                    make.leading.equalTo(view.snp.leading).offset(41.5)
                    make.top.equalTo(view.snp.top).offset(78.5)
                }
            case 812:
                labelWhere.snp.makeConstraints { make in
                    labelWhere.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 45)
                    labelWhere.addCharacterSpacing(kernValue: -0.9)
                    labelWhere.setTextWithLineHeight(text: labelWhere.text, lineHeight: 52)

                    make.leading.equalTo(view.snp.leading).offset(31)
                    make.top.equalTo(view.snp.top).offset(90)
                }
            case 844:
                labelWhere.snp.makeConstraints { make in
                    labelWhere.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 45)
                    labelWhere.addCharacterSpacing(kernValue: -0.9)
                    labelWhere.setTextWithLineHeight(text: labelWhere.text, lineHeight: 52)

                    make.leading.equalTo(view.snp.leading).offset(31)
                    make.top.equalTo(view.snp.top).offset(110.3)
                }
            case 896:
                labelWhere.snp.makeConstraints { make in
                    labelWhere.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 48)
                    labelWhere.addCharacterSpacing(kernValue: -0.96)
                    labelWhere.setTextWithLineHeight(text: labelWhere.text, lineHeight: 55)

                    make.leading.equalTo(view.snp.leading).offset(38.1)
                    make.top.equalTo(view.snp.top).offset(110.3)
                }
            case 926:
                labelWhere.snp.makeConstraints { make in
                    labelWhere.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 48)
                    labelWhere.addCharacterSpacing(kernValue: -0.96)
                    labelWhere.setTextWithLineHeight(text: labelWhere.text, lineHeight: 55)

                    make.leading.equalTo(view.snp.leading).offset(38.1)
                    make.top.equalTo(view.snp.top).offset(110.3)
                }
            default:
                labelWhere.snp.makeConstraints { make in
                    labelWhere.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 45)
                    labelWhere.addCharacterSpacing(kernValue: -0.9)
                    labelWhere.setTextWithLineHeight(text: labelWhere.text, lineHeight: 52)

                    make.leading.equalTo(imageViewHuman.snp.leading)
                    make.bottom.equalTo(imageViewHuman.snp.top)
                }
        }
        
    }
    // MARK: 서치바
    func searchBarSet() {
        searchBar.delegate = self
        searchBar.placeholder = ""
        searchBar.layer.cornerRadius = 24
        searchBar.layer.masksToBounds = true
        searchBar.setImage(UIImage(named: "icSearchCancel@3x"), for: .clear, state: .normal)
        searchBar.layer.shadowOffset = CGSize(width: 3, height: 2)
        searchBar.layer.shadowColor = UIColor.bluegray.cgColor
        searchBar.setTextFieldColor(.white, searchBar)
        view.addSubview(searchBar)
        switch Constant.userPhoneHeight {
        case 667:
            searchBar.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(view.snp.bottom).offset(-226.4)
                make.height.equalTo(48.5)
                make.width.equalTo(343)
            }
        case 736:
            searchBar.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(view.snp.bottom).offset(-243)
                make.height.equalTo(48.5)
                make.width.equalTo(383)
            }
        case 812:
            searchBar.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(view.snp.bottom).offset(-293.8)
                make.height.equalTo(48.5)
                make.width.equalTo(343)
            }
        case 844:
            searchBar.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(view.snp.bottom).offset(-296)
                make.height.equalTo(48.5)
                make.width.equalTo(358)
            }
        case 896:
            searchBar.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(view.snp.bottom).offset(-312)
                make.height.equalTo(48.5)
                make.width.equalTo(382)
            }
        case 926:
            searchBar.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(view.snp.bottom).offset(-313)
                make.height.equalTo(48.5)
                make.width.equalTo(396)
            }
        default:
            searchBar.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(view.snp.bottom).offset(-323.8)
                make.height.equalTo(48.5)
                make.width.equalTo(343)
            }
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
        nextVC.mountainTopAltitude = result.high
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.labelMountainName.text = searchBar.text
        self.present(nextVC, animated: true, completion: nil)
    }
    func failureNoDataMountain(_ message : String) {
        self.presentAlert(title: message)
    }
}
