//
//  ContentMountainViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/07.
//

import UIKit

class ContentMountainViewController: UIViewController {

    let labelMountainName = UILabel()
    let imageViewMountain = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        viewSetPath()
        labelSetMountainName()
        imageViewSetMountain()
        setPositon()
        setHeight()
        SetCourse()
        tableViewSetCourse()
        SetWarning()
        }

    //MARK: 산이름
    func labelSetMountainName () {
        labelMountainName.text = "인왕산"
        labelMountainName.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 32)
        view.addSubview(labelMountainName)
        labelMountainName.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(27)
            make.top.equalTo(view.snp.top)
        }
    }
    //MARK: 산 사진
    func imageViewSetMountain() {
        imageViewMountain.backgroundColor = .mainColor
        imageViewMountain.layer.cornerRadius = 18
        view.addSubview(imageViewMountain)
        imageViewMountain.snp.makeConstraints { make in
            make.top.equalTo(labelMountainName.snp.bottom).offset(13)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(329)
            make.height.equalTo(197)
        }
    }
    //MARK: 점선
    func viewSetPath() {
        let contentView = pathView(frame: self.view.frame)
        view.addSubview(contentView)
        view.backgroundColor = .clear
    }
    //MARK: 위치
    let imageViewPosition = UIImageView()
    let labelPosition = UILabel()
    let labelAddress = UILabel()
    
    func setPositon() {
        imageViewPosition.image = UIImage(named: "positionAndCircle@3x")
        view.addSubview(imageViewPosition)
        imageViewPosition.snp.makeConstraints { make in
            make.leading.equalTo(imageViewMountain.snp.leading)
            make.top.equalTo(imageViewMountain.snp.bottom).offset(13)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        
        labelPosition.text = "위치"
        labelPosition.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelPosition.textColor = .titleColorGray
        view.addSubview(labelPosition)
        labelPosition.snp.makeConstraints { make in
            make.leading.equalTo(imageViewPosition.snp.trailing).offset(3)
            make.centerY.equalTo(imageViewPosition.snp.centerY)
        }
        
        labelAddress.text = "서울 특별시 종로구 서대문구"
        labelAddress.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelAddress.numberOfLines = 2
        view.addSubview(labelAddress)
        labelAddress.snp.makeConstraints { make in
            make.top.equalTo(labelPosition.snp.top)
            make.leading.equalTo(labelPosition.snp.trailing).offset(15)
            make.width.equalTo(252)
        }
    }
    //MARK: 높이
    let imageViewHeight = UIImageView()
    let labelHeight = UILabel()
    let labelHeightConstant = UILabel()
    
    func setHeight() {
        imageViewHeight.image = UIImage(named: "mountainICON@3x")
        view.addSubview(imageViewHeight)
        imageViewHeight.snp.makeConstraints { make in
            make.leading.equalTo(imageViewPosition.snp.leading)
            make.top.equalTo(imageViewPosition.snp.bottom).offset(21)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        
        labelHeight.text = "높이"
        labelHeight.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelHeight.textColor = .titleColorGray
        view.addSubview(labelHeight)
        labelHeight.snp.makeConstraints { make in
            make.leading.equalTo(imageViewHeight.snp.trailing).offset(3)
            make.centerY.equalTo(imageViewHeight.snp.centerY)
        }
        
        labelHeightConstant.text = "339.8m"
        labelHeightConstant.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        view.addSubview(labelHeightConstant)
        labelHeightConstant.snp.makeConstraints { make in
            make.top.equalTo(labelHeight.snp.top)
            make.leading.equalTo(labelHeight.snp.trailing).offset(15)
        }
    }
    //MARK: 등산코스
    let imageViewCourse = UIImageView()
    let labelCourse = UILabel()
    
    func SetCourse() {
        imageViewCourse.image = UIImage(named: "milestone@3x")
        view.addSubview(imageViewCourse)
        imageViewCourse.snp.makeConstraints { make in
            make.leading.equalTo(imageViewPosition.snp.leading)
            make.top.equalTo(imageViewHeight.snp.bottom).offset(27)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        labelCourse.text = "등산\n코스"
        labelCourse.numberOfLines = 2
        labelCourse.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelCourse.textColor = .titleColorGray
        view.addSubview(labelCourse)
        labelCourse.snp.makeConstraints { make in
            make.leading.equalTo(imageViewCourse.snp.trailing).offset(3)
            make.centerY.equalTo(imageViewCourse.snp.centerY).offset(9)
        }
    }
    //MARK: 등산코스 테이블 뷰
    let tableViewCourse = UITableView()
    
    func tableViewRegister() {
        tableViewCourse.register(CourseTableViewCell.self, forCellReuseIdentifier: CourseTableViewCell.identifier)
        tableViewCourse.delegate = self
        tableViewCourse.dataSource = self
    }
    func tableViewSetCourse() {
        tableViewRegister()
        tableViewCourse.separatorStyle = .none
        tableViewCourse.isScrollEnabled = false
        view.addSubview(tableViewCourse)
        tableViewCourse.snp.makeConstraints { make in
            make.top.equalTo(labelCourse.snp.top)
            make.leading.equalTo(labelCourse.snp.trailing).offset(15)
            make.width.equalTo(226)
            make.height.equalTo(26 * 5 + 6 * 6)
        }
    }
    //MARK: 워험사항
    let labelWarningExplain = UILabel()
    let labelWarning = UILabel()
    let imageViewWarning = UIImageView()
    
    func SetWarning() {
        labelWarningExplain.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelWarningExplain.textColor = .darkbluegray
        labelWarningExplain.numberOfLines = 10
        view.addSubview(labelWarningExplain)
        labelWarningExplain.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(tableViewCourse.snp.bottom).offset(19)
            make.width.equalTo(168)
        }
        labelWarning.text = "주의\n사항"
        labelWarning.numberOfLines = 2
        labelWarning.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelWarning.textColor = UIColor(hex: 0x7c909b)
        view.addSubview(labelWarning)
        labelWarning.snp.makeConstraints { make in
            make.leading.equalTo(labelCourse.snp.leading)
            make.top.equalTo(labelWarningExplain.snp.top)
        }
        imageViewWarning.image = UIImage(named: "Warning@3x")
        view.addSubview(imageViewWarning)
        imageViewWarning.snp.makeConstraints { make in
            make.leading.equalTo(imageViewCourse.snp.leading)
            make.top.equalTo(labelWarning.snp.top)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
    }
}

//MARK: 등산코스 테이블 뷰 extension
extension ContentMountainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CourseTableViewCell.identifier, for: indexPath) as? CourseTableViewCell
        else {
            fatalError("cant dequeue Cell")
        }
        cell.selectionStyle = .none
        cell.buttonCourse.setTitle("\(indexPath.row)코스", for: .normal)
        cell.labelDistanse.text = "3.2km"
        cell.labelTimes.text = "2h 30m"
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5 // 코스 수
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 26
    }
}
