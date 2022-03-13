//
//  FlagExplainViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/26.
//

import UIKit

class FirstCheckViewController : UIViewController {
    var boolAge : Bool = false
    var boolPrivacy : Bool = false
    var boolTermUse : Bool = false
    var boolAd : Bool = false
    
    let viewModel = AgreeViewModel()
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.alpha = 0.7
            return view
        }()
      
      // 2
      override func viewDidLoad() {
          super.viewDidLoad()
          setupUI()
          viewSetContent()
          setCheck()
          setTableView()
      }
    
      // 3
      private func setupUI() {
          view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
      }
    // MARK: 내용이 들어갈 뷰
    let viewContent = UIView()
    func viewSetContent() {
        viewContent.layer.cornerRadius = 25
        viewContent.backgroundColor = .white
        view.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.trailing.leading.equalTo(view)
            make.height.equalTo(425)
        }
    }
    //MARK: 내용
    let labelExplain : UILabel = {
        let label = UILabel()
        label.text = "만나서 반가워요:)\n서비스 이용을 위한 몇 가지 동의가 필요해요!"
        label.numberOfLines = 2
        label.textColor = .darkbluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)
        return label
    }()
    let buttonAllAccept : UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        return button
    }()
    @objc func actionAllAccept() {
        if boolAd, boolAge, boolPrivacy, boolTermUse {
            boolAd = false
            boolAge = false
            boolPrivacy = false
            boolTermUse = false
            imageViewAllCheck.image =  UIImage(named: "icSignupCheckboxCircleunselected")
            buttonStart.backgroundColor = .lightbluegray
        } else {
            boolAd = true
            boolAge = true
            boolPrivacy = true
            boolTermUse = true
            imageViewAllCheck.image =  UIImage(named: "icSignupCheckboxCircle")
            buttonStart.backgroundColor = .mainColor
        }
        
        tableViewAccept.reloadData()
    }
    let imageViewAllCheck : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "icSignupCheckboxCircleunselected")
        return imageView
    }()
    let labelAllAccept : UILabel = {
        let label = UILabel()
        label.text = "전체 동의합니다."
        label.textColor = .darkbluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)
        return label
    }()
    let viewBorderButton : UIView = {
        let view = UIView()
        view.backgroundColor = .lightbluegray
        return view
    }()
    // 시작하기 버튼
    let buttonStart : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 24
        button.backgroundColor = .lightbluegray
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    @objc func actionStart() {
        if boolAd, boolAge, boolPrivacy, boolTermUse {
            viewModel.appUsersAgree { result in
                if result == "" {
                    self.presentAlert(title: "네트워크 오류")
                } else {
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
    
    func setCheck() {
        viewContent.addSubview(labelExplain)
        labelExplain.snp.makeConstraints { make in
            make.leading.top.equalTo(24)
        }
        
        buttonAllAccept.addTarget(self, action: #selector(actionAllAccept), for: .touchUpInside)
        viewContent.addSubview(buttonAllAccept)
        buttonAllAccept.snp.makeConstraints { make in
            make.top.equalTo(labelExplain.snp.bottom).offset(16)
            make.leading.equalTo(viewContent).offset(24)
            make.trailing.equalTo(viewContent).offset(-24)
            make.height.equalTo(38)
        }
        
       
        viewContent.addSubview(imageViewAllCheck)
        imageViewAllCheck.snp.makeConstraints { make in
            make.leading.equalTo(buttonAllAccept)
            make.centerY.equalTo(buttonAllAccept)
            make.width.height.equalTo(26)
        }
        
        viewContent.addSubview(labelAllAccept)
        labelAllAccept.snp.makeConstraints { make in
            make.centerY.equalTo(buttonAllAccept)
            make.leading.equalTo(imageViewAllCheck.snp.trailing).offset(5.8)
        }
        
        viewContent.addSubview(viewBorderButton)
        viewBorderButton.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.leading.trailing.equalTo(buttonAllAccept)
            make.top.equalTo(buttonAllAccept.snp.bottom)
        }
        
        //MARK: 하단 시작하기 버튼
        buttonStart.addTarget(self, action: #selector(actionStart), for: .touchUpInside)
        viewContent.addSubview(buttonStart)
        buttonStart.snp.makeConstraints { make in
            make.centerX.equalTo(viewContent)
            make.leading.trailing.equalTo(buttonAllAccept)
            make.bottom.equalTo(viewContent).offset(-60)
            make.height.equalTo(48)
        }
    }
    
    //동의 테이블 뷰
    let tableViewAccept : UITableView = {
        let tableView = UITableView()
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    func setTableView() {
        tableViewAccept.delegate = self
        tableViewAccept.dataSource = self
        tableViewAccept.register(AcceptTableViewCell.self, forCellReuseIdentifier: AcceptTableViewCell.resueidentifier)
        
        viewContent.addSubview(tableViewAccept)
        tableViewAccept.snp.makeConstraints { make in
            make.top.equalTo(viewBorderButton.snp.bottom).offset(9)
            make.leading.trailing.equalTo(buttonAllAccept)
            make.bottom.equalTo(buttonStart.snp.top).offset(-21)
        }
    }
}

extension FirstCheckViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AcceptTableViewCell.resueidentifier, for: indexPath) as? AcceptTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.labelExplain.text = "[필수] 이용약관에 동의 합니다."
            cell.buttonGoPDF.tag = indexPath.row
            cell.buttonGoPDF.isHidden = false
            if boolTermUse {
                cell.imageViewisCheck.image = UIImage(named: "icSignupCheck")
            } else {
                cell.imageViewisCheck.image = UIImage(named: "icSignupCheckUnseleted")
            }
        } else if indexPath.row == 1 {
            cell.labelExplain.text = "[필수] 개인정보 수집 및 이용에 동의합니다."
            cell.buttonGoPDF.tag = indexPath.row
            cell.buttonGoPDF.isHidden = false

            if boolPrivacy {
                cell.imageViewisCheck.image = UIImage(named: "icSignupCheck")
            } else {
                cell.imageViewisCheck.image = UIImage(named: "icSignupCheckUnseleted")
            }
        } else if indexPath.row == 2 {
            cell.labelExplain.text = "[필수] 만 14세 이상입니다."
            cell.buttonGoPDF.isHidden = true
            
            if boolAge {
                cell.imageViewisCheck.image = UIImage(named: "icSignupCheck")
            } else {
                cell.imageViewisCheck.image = UIImage(named: "icSignupCheckUnseleted")
            }
        } else {
            cell.labelExplain.text = "[선택] 앱 푸시 및 마케팅/이벤트 수신 동의"
            cell.buttonGoPDF.isHidden = true
            
            if boolAd {
                cell.imageViewisCheck.image = UIImage(named: "icSignupCheck")
            } else {
                cell.imageViewisCheck.image = UIImage(named: "icSignupCheckUnseleted")
            }
        }
        
        cell.buttonGoPDF.addTarget(self, action: #selector(actionGoPDF(_:)), for: .touchUpInside)

        return cell
    }
    @objc func actionGoPDF(_ button: UIButton) {
        switch button.tag {
        case 0:
            let nextVC = TermsOfServiceDetailViewController()
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .crossDissolve
            self.present(nextVC, animated: true, completion: nil)
        case 1:
            let nextVC = PrivacyUserDetailViewController()
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .crossDissolve
            self.present(nextVC, animated: true, completion: nil)
        default:
            print("error")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if boolTermUse {
                boolTermUse = false
                imageViewAllCheck.image =  UIImage(named: "icSignupCheckboxCircleunselected")
            } else {
                boolTermUse = true
            }
        }
        else if indexPath.row == 1 {
            if boolPrivacy {
                boolPrivacy = false
                imageViewAllCheck.image =  UIImage(named: "icSignupCheckboxCircleunselected")
            } else {
                boolPrivacy = true
            }
        }
        else if indexPath.row == 2 {
            if boolAge {
                boolAge = false
                imageViewAllCheck.image =  UIImage(named: "icSignupCheckboxCircleunselected")
            } else {
                boolAge = true
            }
        }
        else {
            if boolAd {
                boolAd = false
                imageViewAllCheck.image =  UIImage(named: "icSignupCheckboxCircleunselected")
            } else {
                boolAd = true
            }
        }
        if boolAd, boolAge, boolPrivacy, boolTermUse {
            buttonStart.backgroundColor = .mainColor
            imageViewAllCheck.image =  UIImage(named: "icSignupCheckboxCircle")

        } else {
            buttonStart.backgroundColor = .lightbluegray
            imageViewAllCheck.image = UIImage(named: "icSignupCheckboxCircleunselected")
        }
        tableViewAccept.reloadData()
    }
    
}
