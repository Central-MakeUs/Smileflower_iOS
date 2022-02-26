//
//  DetailMessageViewController.swift
//  santaApp
//
//  Created by 노영재 on 2022/01/30.
//

import UIKit

class DetailMessageViewController: BaseViewController {
    var arrayBool : [Bool] = []
    var flagIndex = 0
    let viewModel = CommentsViewModel()
    var arrayComments : [commentsResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setBottomChatView()
        setTableView()
        
        let input = inputComments(type: "flag")
            viewModel.appCommentsIdx(input, flagIndex) { result, array in
                self.arrayComments = result.result ?? []
                self.arrayBool = array
                self.tableViewMessage.reloadData()
            }
        
        }
        override func viewWillAppear(_ animated: Bool) {
            setNotification()
            dismissKeyboardWhenTappedAround()
        }
        override func viewWillDisappear(_ animated: Bool) {
            removeKeyboardNotifications()
        }
        func setNotification() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        // 노티피케이션을 제거하는 메서드
        func removeKeyboardNotifications(){
            // 키보드가 나타날 때 앱에게 알리는 메서드 제거
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
            // 키보드가 사라질 때 앱에게 알리는 메서드 제거
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil) }
        var fCurTextfieldBottom: CGFloat = 0.0
        
        @objc func keyboardWillShow(notification: NSNotification) {
               if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

                   if self.view.frame.origin.y == 0.0 {
                       self.view.frame.origin.y -= keyboardSize.height - 35
                   }
               }
           }
        @objc func keyboardWillHide(notification: NSNotification) {
                if self.view.frame.origin.y != 0 {
                    self.view.frame.origin.y = 0
                }
            }
        
        //MARK: NavigationBar
        @objc func actionRightButton(_ sender : UIBarButtonItem) {
            print("버튼")
        }
        func setNavigationBar() {
            let height: CGFloat = 75
            let navbar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: height))
            navbar.backgroundColor = UIColor.clear
            navbar.delegate = self

            let navItem = UINavigationItem()
            navItem.leftBarButtonItem = self.leftButton
            navbar.items = [navItem]
            navbar.setBackgroundImage(UIImage(), for: .default)
            navbar.shadowImage = UIImage()
            navbar.layoutIfNeeded()
            view.addSubview(navbar)
        }
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .titleColorGray
        return button
    }()
    @objc func actionBackButton(_ sender : Any) {
        self.navigationController?.popViewController(animated: true)
    }
        //MARK: 하단텍스트 필드
        let viewChatBack : UIView = {
            let view = UIView()
            view.layer.shadowColor = UIColor.lightbluegray.cgColor
            view.layer.shadowOpacity = 0.28
            view.layer.shadowRadius = 3
            view.layer.shadowOffset = CGSize(width: 0, height: -1)
            return view
        }()
        
        let imageVUewUserProfile : UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 17.5
            imageView.backgroundColor = .mainColor
            return imageView
        }()
        
        let textFieldWriteMessage : UITextField = {
            let textField = UITextField()
            textField.placeholder = "댓글을 입력해주세요."
            textField.layer.borderColor = UIColor.lightbluegray.cgColor
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 20
            textField.addLeftPadding()
            
            let button = UIButton()
            button.setTitle("등록", for: .normal)
            button.frame = CGRect(x: -16, y: 0, width: 36, height: 36)
            button.setTitleColor(.mainColor, for: .normal)
            
            textField.rightView = button
            textField.rightViewMode = UITextField.ViewMode.always
            
            return textField
        }()
        
        
        
        func setBottomChatView() {
            view.addSubview(viewChatBack)
            viewChatBack.snp.makeConstraints { make in
                make.leading.trailing.equalTo(view)
                make.bottom.equalTo(view).offset(-35)
                make.height.equalTo(68)
            }
            
            viewChatBack.addSubview(imageVUewUserProfile)
            imageVUewUserProfile.snp.makeConstraints { make in
                make.width.height.equalTo(35)
                make.centerY.equalTo(viewChatBack)
                make.leading.equalTo(viewChatBack).offset(17)
            }
            
            textFieldWriteMessage.delegate = self
            viewChatBack.addSubview(textFieldWriteMessage)
            textFieldWriteMessage.snp.makeConstraints { make in
                make.centerY.equalTo(viewChatBack)
                make.height.equalTo(40)
                make.leading.equalTo(imageVUewUserProfile.snp.trailing).offset(6)
                make.trailing.equalTo(viewChatBack).offset(-17)
            }
        }
        
        //MARK: 댓글 보기
        let tableViewMessage : UITableView = {
            let tableView = UITableView()
            tableView.layer.zPosition = 999
            return tableView
        }()
        func setTableView() {
            tableViewMessage.delegate = self
            tableViewMessage.dataSource = self
            tableViewMessage.separatorStyle = .none
            let nib = UINib(nibName: "CommentsTableViewCell", bundle: nil)
            tableViewMessage.register(nib, forCellReuseIdentifier: CommentsTableViewCell.resueidentifier)
            tableViewMessage.register(HaveCommentsTableViewCell.self, forCellReuseIdentifier: HaveCommentsTableViewCell.resueidentifier)
            tableViewMessage.register(DoubleMessageTableViewCell.self, forCellReuseIdentifier: DoubleMessageTableViewCell.resueidentifier)
            tableViewMessage.estimatedRowHeight = 60
            tableViewMessage.rowHeight = UITableView.automaticDimension
            view.addSubview(tableViewMessage)
            tableViewMessage.snp.makeConstraints { make in
                make.top.trailing.leading.equalTo(view)
                make.bottom.equalTo(viewChatBack.snp.top)
            }
        }
    }

    extension DetailMessageViewController : UITableViewDelegate, UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return arrayComments.count
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let arrayRecomment = arrayComments[section].getRecommentRes {
                if arrayBool[section] {
                    return 1 + arrayRecomment.count
                } else {
                    return 1
                }
            } else {
                return 1
            }
            
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // 댓글 구현
            if indexPath.row == 0 {
                
                if let comments = arrayComments[indexPath.section].getRecommentRes {
                    if comments.isEmpty {
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.resueidentifier, for: indexPath) as? CommentsTableViewCell else {
                            return UITableViewCell()
                        }
                        
                        cell.selectionStyle = .none
                        if let urlString = arrayComments[indexPath.section].userImageUrl {
                            let url = URL(string: urlString)
                            cell.imageViewUserProfile.kf.setImage(with: url)
                        } else {
                            cell.imageViewUserProfile.image = UIImage(named: "personhome")
                        }
                        let contentsString = "\(arrayComments[indexPath.section].userName ?? "") \(arrayComments[indexPath.section].contents ?? "")"
                        let fontSize = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 13)
                        let attributeStr = NSMutableAttributedString(string: contentsString)
                        attributeStr.addAttribute(.font, value: fontSize, range: NSRange.init(location: 0, length: arrayComments[indexPath.section].userName?.count ?? 0))
                        cell.labelMessage.attributedText = attributeStr
                        cell.labelWhenPostMessage.text = arrayComments[indexPath.section].createdAt
                        
                        return cell
                    } else {
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: HaveCommentsTableViewCell.resueidentifier, for: indexPath) as? HaveCommentsTableViewCell else {
                            return UITableViewCell()
                        }
                        
                        cell.selectionStyle = .none
                        if let urlString = arrayComments[indexPath.section].userImageUrl {
                            let url = URL(string: urlString)
                            cell.imageViewUserProfile.kf.setImage(with: url)
                        } else {
                            cell.imageViewUserProfile.image = UIImage(named: "personhome")
                        }
                        let contentsString = "\(arrayComments[indexPath.section].userName ?? "") \(arrayComments[indexPath.section].contents ?? "")"
                        let fontSize = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 13)
                        let attributeStr = NSMutableAttributedString(string: contentsString)
                        attributeStr.addAttribute(.font, value: fontSize, range: NSRange.init(location: 0, length: arrayComments[indexPath.section].userName?.count ?? 0))
                        cell.labelMessage.attributedText = attributeStr
                        cell.labelWhenPostMessage.text = arrayComments[indexPath.section].createdAt
                        
                        cell.buttonSeeComments.tag = indexPath.section
                        cell.buttonSeeComments.addTarget(self, action: #selector(actionOpenComments(button:)), for: .touchUpInside)
                        
                        if arrayBool[indexPath.section] {
                            cell.labelSeeComments.text = "답글 숨기기"
                            cell.imageViewUpDown.image = UIImage(named: "icChatArrowUp")
                        }   else {
                            if let comments = arrayComments[indexPath.section].getRecommentRes {
                                cell.labelSeeComments.text = "\(comments.count)개의 답글 모두 보기"
                            }
                            cell.imageViewUpDown.image = UIImage(named: "icChatArrowDown")
                        }
                        return cell
                    }
                }
            }
            // 대댓글 구현
            else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DoubleMessageTableViewCell.resueidentifier, for: indexPath) as? DoubleMessageTableViewCell else {
                    return UITableViewCell()
                }
                if let comments = arrayComments[indexPath.section].getRecommentRes {
                    cell.contentView.backgroundColor = .white
                    
                    if let urlString = comments[indexPath.row - 1].userImageUrl {
                        let url = URL(string: urlString)
                        cell.imageViewUserProfile.kf.setImage(with: url)
                    } else {
                        cell.imageViewUserProfile.image = UIImage(named: "personhome")
                    }
                    
                    let contentsString = "\(comments[indexPath.row - 1].userName ?? "") \(comments[indexPath.row - 1].contents ?? "")"
                    let fontSize = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 13)
                    let attributeStr = NSMutableAttributedString(string: contentsString)
                    attributeStr.addAttribute(.font, value: fontSize, range: NSRange.init(location: 0, length: comments[indexPath.row - 1].userName?.count ?? 0))
                    cell.labelMessage.attributedText = attributeStr
                    cell.labelWhenPostMessage.text = comments[indexPath.row - 1].createdAt
                }
                return cell
            }
            
            return UITableViewCell()
        }
        @objc func actionOpenComments(button: UIButton) {
            if arrayBool[button.tag] {
                arrayBool[button.tag] = false
                let section = IndexSet.init(integer: button.tag)
                tableViewMessage.reloadSections(section, with: .fade)
            } else {
                arrayBool[button.tag] = true
                let section = IndexSet.init(integer: button.tag)
                tableViewMessage.reloadSections(section, with: .fade)
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        guard let cell = tableView.cellForRow(at: indexPath) as? CommentsTableViewCell else {
    //            return
    //        }
    //        guard let index = tableView.indexPath(for: cell) else { return}
    //        if index.row == indexPath.row {
    //            if index.row == 0 {
    //                if arrayBool[indexPath.section] {
    //                    arrayBool[indexPath.section] = false
    //                    let section = IndexSet.init(integer: indexPath.section)
    //                    tableView.reloadSections(section, with: .fade)
    //                } else {
    //                    arrayBool[indexPath.section] = true
    //                    let section = IndexSet.init(integer: indexPath.section)
    //                    tableView.reloadSections(section, with: .fade)
    //                }
    //            }
    //        }
        }
        
    }
    extension DetailMessageViewController : UITextFieldDelegate {
        
    }
