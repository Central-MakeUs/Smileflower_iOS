//
//  MountainCourseTableViewCell.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/08.
//

import UIKit

class MountainCourseTableViewCell: UITableViewCell {
    
    static let identifier = "MountainCourseTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageViewSetPosition()
        labelSetPosition()
        setContentView()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: 코스
    let imageViewCourse = UIImageView()
    func imageViewSetPosition() {
        imageViewCourse.image = UIImage(named: "milestone@3x")
        contentView.addSubview(imageViewCourse)
        imageViewCourse.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(22)
            make.leading.equalTo(contentView.snp.leading).offset(25)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
    }
    //MARK: 코스 라벨
    let labelCourse = UILabel()
    func labelSetPosition() {
        labelCourse.text = "등산\n코스"
        labelCourse.numberOfLines = 2
        labelCourse.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelCourse.textColor = .titleColorGray
        contentView.addSubview(labelCourse)
        labelCourse.snp.makeConstraints { make in
            make.top.equalTo(imageViewCourse.snp.top)
            make.leading.equalTo(imageViewCourse.snp.trailing).offset(3)
        }
    }
    //MARK: 테이블뷰 해더 뷰
    let viewTitle = UIView()
    func setContentView() {
        contentView.addSubview(viewTitle)
        viewTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(186)
            make.trailing.equalTo(contentView.snp.trailing).offset(-54)
            make.height.equalTo(22)

        }
        let imageViewRunning = UIImageView()
        imageViewRunning.image = UIImage(named: "icInfoDistance@3x")
        viewTitle.addSubview(imageViewRunning)
        imageViewRunning.snp.makeConstraints { make in
            make.leading.equalTo(viewTitle.snp.leading).offset(0.5)
            make.centerY.equalTo(viewTitle.snp.centerY)
            make.width.equalTo(16.2)
            make.height.equalTo(13.7)
        }
        let labelRunning = UILabel()
        labelRunning.text = "거리"
        labelRunning.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelRunning.textColor = .bluegray
        viewTitle.addSubview(labelRunning)
        labelRunning.snp.makeConstraints { make in
            make.centerY.equalTo(viewTitle.snp.centerY)
            make.leading.equalTo(imageViewRunning.snp.trailing).offset(3.3)
        }
        
        let imageViewTime = UIImageView()
        imageViewTime.image = UIImage(named: "icInfoTime@3x")
        viewTitle.addSubview(imageViewTime)
        imageViewTime.snp.makeConstraints { make in
            make.leading.equalTo(labelRunning.snp.trailing).offset(12.7)
            make.centerY.equalTo(viewTitle.snp.centerY)
            make.width.equalTo(15.8)
            make.height.equalTo(15.8)
        }
        
        let labelTime = UILabel()
        labelTime.text = "소요시간"
        labelTime.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 16)
        labelTime.textColor = .bluegray
        viewTitle.addSubview(labelTime)
        labelTime.snp.makeConstraints { make in
            make.centerY.equalTo(viewTitle.snp.centerY)
            make.leading.equalTo(imageViewTime.snp.trailing).offset(3.2)
        }
    }
    //MARK: 코스 테이블뷰
    let tableViewCourse = UITableView()
    func registerCell() {
        tableViewCourse.delegate = self
        tableViewCourse.dataSource = self
        
        tableViewCourse.register(CourseTableViewCell.self, forCellReuseIdentifier: CourseTableViewCell.identifier)
        contentView.addSubview(tableViewCourse)
        tableViewCourse.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom)
            make.leading.equalTo(labelCourse.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-50)
            make.height.equalTo(26 * 5 + 6 * 7)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
extension MountainCourseTableViewCell : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 26
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CourseTableViewCell.identifier, for: indexPath)as? CourseTableViewCell
        else {
            fatalError("cant dequeue Cell")
            }
        cell.selectionStyle = .none
        cell.buttonCourse.setTitle("\(indexPath.row)코스", for: .normal)
        cell.labelTimes.text = "2h 30m"
        cell.labelDistanse.text = "3.2"
        
        return cell
    }
    
    
}
