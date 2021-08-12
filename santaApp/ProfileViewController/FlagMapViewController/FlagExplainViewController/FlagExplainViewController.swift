//
//  FlagExplainViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/26.
//

import UIKit

class FlagExplainViewController : BaseViewController {
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
        setLabelTitle()
        setLabelExplainFlag()
        setImageViewExplainFlag()
        setButtonDismiss()
        
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
            dimmedView.addGestureRecognizer(dimmedTap)
            dimmedView.isUserInteractionEnabled = true
      }
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
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
            make.centerY.equalTo(view.snp.centerY).offset(17.5)
            make.width.equalTo(319)
            make.height.equalTo(212)
        }
    }
    //MARK: 깃발 종류 라벨
    let labelTitle = UILabel()
    func setLabelTitle() {
        labelTitle.text = "깃발 종류"
        labelTitle.font = UIFont(name: Constant.fontAppleSDGothicNeoSemiBold, size: 16)
        labelTitle.addCharacterSpacing(kernValue: -0.38)
        labelTitle.textColor = .darkbluegray
        labelTitle.textAlignment = .center
        viewContent.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { make in
            make.centerX.equalTo(viewContent.snp.centerX)
            make.top.equalTo(viewContent.snp.top).offset(19)
        }
    }
    //MARK: 깃발 설명 라벨
    let labelExplainFlag = UILabel()
    func setLabelExplainFlag() {
        labelExplainFlag.text = "같은 산을 여러번 정복할 때마다\n깃발의 모양이 변합니다."
        labelExplainFlag.numberOfLines = 2
        labelExplainFlag.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 14)
        labelExplainFlag.textColor = .bluegray
        labelExplainFlag.textAlignment = .center
        viewContent.addSubview(labelExplainFlag)
        labelExplainFlag.snp.makeConstraints { make in
            make.centerX.equalTo(viewContent.snp.centerX)
            make.top.equalTo(labelTitle.snp.bottom).offset(9)
        }
    }
    //MARK: 깃발 설명 이미지
    let imageViewExplainFlag = UIImageView()
    func setImageViewExplainFlag() {
        imageViewExplainFlag.image = UIImage(named: "illustProfileStep@3x")
        imageViewExplainFlag.contentMode = .scaleAspectFit
        viewContent.addSubview(imageViewExplainFlag)
        imageViewExplainFlag.snp.makeConstraints { make in
            make.centerX.equalTo(viewContent.snp.centerX)
            make.top.equalTo(labelExplainFlag.snp.bottom).offset(16)
            make.width.equalTo(218)
            make.height.equalTo(87)
        }
    }
    //MARK: 창 지우기
    let buttonDismiss = UIButton()
    func setButtonDismiss() {
        buttonDismiss.setImage(UIImage(systemName: "xmark"), for: .normal)
        buttonDismiss.addTarget(self, action: #selector(actionDismiss), for: .touchUpInside)
        viewContent.addSubview(buttonDismiss)
        buttonDismiss.snp.makeConstraints { make in
            make.top.equalTo(viewContent).offset(15)
            make.trailing.equalTo(viewContent).offset(-15)
            make.width.height.equalTo(26)
        }
    }
    @objc func actionDismiss() {
        self.dismiss(animated: false, completion: nil)
    }
}
