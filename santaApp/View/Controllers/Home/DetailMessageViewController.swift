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
    var commentIndex = 0
    var previousView = ""
    let viewModel = CommentsViewModel()
    let viewModelWriteComment = writeCommentViewModel()
    var arrayComments : [commentsResult] = []
    let viewModelUserImage = userimageViewModel()
    let viewModelRecomments = ReCommentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setBottomChatView()
        setTableView()
        setViewDoubleComment()
        
        let input = inputComments(type: "flag")
            viewModel.appCommentsIdx(input, flagIndex) { result, array in
                self.arrayComments = result.result ?? []
                self.arrayBool = array
                self.tableViewMessage.reloadData()
            }
        viewModelUserImage.appCommentsUserImage { result in
            if let urlString = result.userImageUrl {
                let url = URL(string: urlString)
                self.imageVUewUserProfile.kf.indicatorType = .activity
                self.imageVUewUserProfile.kf.setImage(with: url)
            } else {
                self.imageVUewUserProfile.image = UIImage(named: "personhome")
            }
        }
        }
        override func viewWillAppear(_ animated: Bool) {
            setNotification()
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
            navbar.topItem?.title = "댓글"
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
        if previousView == "Home" {
            self.tabBarController?.tabBar.isHidden = false
            NotificationCenter.default.post(name: Notification.Name("middleButtonAppear"), object: nil)
            self.navigationController?.popViewController(animated: true)
        }
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
            
            return textField
        }()
    @objc func actionTextfieldWrite(textfield:UITextField) {
        if let text = textfield.text {
            if text.isEmpty {
                buttonEnroll.alpha = 0.7
            } else {
                buttonEnroll.alpha = 1
            }
        }
    }
    let buttonEnroll : UIButton = {
        let button = UIButton()
        button.setTitle("등록", for: .normal)
        button.layer.zPosition = 999
        button.alpha = 0.7
        button.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 14)
        button.setTitleColor(.mainColor, for: .normal)
        return button
    }()
        
    @objc func actionEnrollComments() {
        showIndicator()
        if viewDoubleComment.alpha == 0 {
            let input = inputWriteComment(contents: textFieldWriteMessage.text ?? "")
                viewModelWriteComment.appCommentsIdxType(input, flagIndex, "flag") { result in
                    self.textFieldWriteMessage.text = ""
                    let input = inputComments(type: "flag")
                    self.viewModel.appCommentsIdx(input, self.flagIndex) { result, array in
                            self.arrayComments = result.result ?? []
                            self.arrayBool = array
                            self.tableViewMessage.reloadData()
                        }
                }
            dismissIndicator()
        } else {
            let input = inputWriteDoubleComment(contents: textFieldWriteMessage.text ?? "")
            print(commentIndex)
            print(flagIndex)
            viewModelRecomments.appCommentsRecommentIdxType(input, commentIndex, "flag") { result in
                self.textFieldWriteMessage.text = ""
                let input = inputComments(type: "flag")
                print("아아아아")
                self.viewModel.appCommentsIdx(input, self.flagIndex) { result, array in
                        self.arrayComments = result.result ?? []
                        self.arrayBool = array
                        self.tableViewMessage.reloadData()
                    }
                
            }
            viewDoubleComment.alpha = 0

            dismissIndicator()
        }
        
    }
    let viewDoubleComment : UIView = {
       let view = UIView()
        view.backgroundColor = .iceblue
        view.alpha = 0
        view.layer.zPosition = 999
        return view
    }()
    
    let labelDoubleComment : UILabel = {
        let label = UILabel()
        label.textColor = .bluegray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoRegular, size: 14)
        return label
    }()
    
    let buttonCloseComment : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .bluegray
        return button
    }()
    
    @objc func actionClose() {
        viewDoubleComment.alpha = 0
    }
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
            textFieldWriteMessage.addTarget(self, action: #selector(actionTextfieldWrite(textfield:)), for: .editingChanged)
            viewChatBack.addSubview(textFieldWriteMessage)
            textFieldWriteMessage.snp.makeConstraints { make in
                make.centerY.equalTo(viewChatBack)
                make.height.equalTo(40)
                make.leading.equalTo(imageVUewUserProfile.snp.trailing).offset(6)
                make.trailing.equalTo(viewChatBack).offset(-17)
            }
            
            buttonEnroll.addTarget(self, action: #selector(actionEnrollComments), for: .touchUpInside)
            viewChatBack.addSubview(buttonEnroll)
            buttonEnroll.snp.makeConstraints { make in
                make.width.height.equalTo(36)
                make.trailing.equalTo(viewChatBack.snp.trailing).offset(-30)
                make.centerY.equalTo(textFieldWriteMessage)
            }
        }
    func setViewDoubleComment() {
        view.addSubview(viewDoubleComment)
        viewDoubleComment.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(viewChatBack.snp.top)
            make.height.equalTo(26)
        }
        
        viewDoubleComment.addSubview(labelDoubleComment)
        labelDoubleComment.snp.makeConstraints { make in
            make.centerY.equalTo(viewDoubleComment)
            make.leading.equalTo(viewDoubleComment).offset(23)
        }
        
        buttonCloseComment.addTarget(self, action: #selector(actionClose), for: .touchUpInside)
        viewDoubleComment.addSubview(buttonCloseComment)
        buttonCloseComment.snp.makeConstraints { make in
            make.height.width.equalTo(viewDoubleComment.snp.height)
            make.trailing.equalTo(viewDoubleComment).offset(-13)
            make.centerY.equalTo(viewDoubleComment)
        }
    }
        
        //MARK: 댓글 보기
        let tableViewMessage : UITableView = {
            let tableView = UITableView()
            tableView.layer.zPosition = 899
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
                make.trailing.leading.equalTo(view)
                make.top.equalTo(view).offset(75)
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
                        if arrayComments[indexPath.section].isUsersComment == "f" {
                            cell.buttonMore.isHidden = true
                        } else {
                            cell.buttonMore.isHidden = false
                        }
                        cell.previoutViewcontroller = self
                        cell.commentIndex = arrayComments[indexPath.section].commentIdx ?? 0
                        cell.commentUserId = arrayComments[indexPath.section].userName ?? ""

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
                        if arrayComments[indexPath.section].isUsersComment == "f" {
                            cell.buttonMore.isHidden = true
                        } else {
                            cell.buttonMore.isHidden = false
                        }
                        cell.previoutViewcontroller = self
                        cell.commentIndex = arrayComments[indexPath.section].commentIdx ?? 0
                        cell.commentUserId = arrayComments[indexPath.section].userName ?? ""

                        let contentsString = "\(arrayComments[indexPath.section].userName ?? "") \(arrayComments[indexPath.section].contents ?? "")"
                        let fontSize = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 13)
                        let attributeStr = NSMutableAttributedString(string: contentsString)
                        attributeStr.addAttribute(.font, value: fontSize, range: NSRange.init(location: 0, length: arrayComments[indexPath.section].userName?.count ?? 0))
                        cell.labelMessage.attributedText = attributeStr
                        cell.labelWhenPostMessage.text = arrayComments[indexPath.section].createdAt
                        
                        cell.buttonSeeComments.tag = indexPath.section
                        cell.buttonSeeComments.addTarget(self, action: #selector(actionOpenComments(button:)), for: .touchUpInside)
                        cell.buttonDoDoubleMessage.tag = arrayComments[indexPath.section].commentIdx ?? 0
                        
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

        }
        
    }
    extension DetailMessageViewController : UITextFieldDelegate {
        
    }
