//
//  RankingMountainViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/05.
//

import UIKit
import MapKit
import BetterSegmentedControl

class RankingMountainViewController: UIViewController {

    let mapView = MKMapView()
    let viewBottomSheet = UIView()

    // MARK: 내용View 만들기.
    private let ViewControllerRanking : UIViewController
    private let ViewControllerMountain : UIViewController
    
    init(contentRankingViewController: ContentRankViewController, contentMountainViewController : ContentMountainViewController) {
        self.ViewControllerRanking = contentRankingViewController
        self.ViewControllerMountain = contentMountainViewController
        super.init(nibName: nil, bundle: nil)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    enum BottomSheetViewState {
            case expanded
            case normal
        }
    var bottomSheetPanMinTopConstant: CGFloat =  -42.5
       // 드래그 하기 전에 Bottom Sheet의 top Constraint value를 저장하기 위한 프로퍼티
    private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    var defaultHeight: CGFloat = UIScreen.main.bounds.height - 275
    
    private let dragIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xC1CAD0)
        view.layer.cornerRadius = 3
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapViewSet()
        navigationBarSet()
        viewSetBottomSheet()
        seguecontrolSet()
        setupMiddleButton()
        
        ViewControllerRanking.view.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(viewBottomSheet)
            make.top.equalTo(control.snp.bottom).offset(14)
        }
        
        ViewControllerMountain.view.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(viewBottomSheet)
            make.top.equalTo(control.snp.bottom).offset(14)
        }
    }
    // navigationBar
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .titleColorGray
        return button
        
    }()
    func navigationBarSet() {
        let height: CGFloat = 30
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
    @objc func actionBackButton(_ sender : Any) {
        self.changeRootViewController(BaseTabbarController())
    }
    // MARK: 지도 구현
    func mapViewSet() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    // MARK: 버튼 구현
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 79.1, height: 79.1))
           var menuButtonFrame = menuButton.frame
           menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 50
           menuButtonFrame.origin.x = view.bounds.width - menuButtonFrame.size.width - 30
           menuButton.frame = menuButtonFrame

           menuButton.backgroundColor = UIColor.mainColor
           menuButton.layer.cornerRadius = menuButtonFrame.height/2
        menuButton.layer.shadowColor = UIColor.mainColor.cgColor
        menuButton.layer.shadowOpacity = 0.3
        menuButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        menuButton.layer.shadowRadius = 18
           view.addSubview(menuButton)

           menuButton.setImage(UIImage(named: "FlagIcon@3x"), for: .normal)
        menuButton.imageEdgeInsets = UIEdgeInsets(top: 1.6, left: 2.15, bottom: -1.6, right: -2.15)
           menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

           view.layoutIfNeeded()
       }
    @objc private func menuButtonAction(sender: UIButton) {
        print("click")
    }
    // MARK: 아래 시트 구현
    func viewSetBottomSheet() {
        addChild(ViewControllerRanking)
        addChild(ViewControllerMountain)
        viewBottomSheet.addSubview(ViewControllerRanking.view)
        viewBottomSheet.addSubview(ViewControllerMountain.view)
        ViewControllerMountain.view.alpha = 0
        ViewControllerRanking.didMove(toParent: self)
        ViewControllerMountain.didMove(toParent: self)
        viewBottomSheet.clipsToBounds = true
        
        viewBottomSheet.layer.shadowColor = UIColor.titleColorGray.cgColor
        viewBottomSheet.layer.shadowOpacity = 0.3
        viewBottomSheet.layer.shadowOffset = CGSize(width: 0, height: -1)
        viewBottomSheet.layer.cornerRadius = 28
        viewBottomSheet.backgroundColor = .white
        viewBottomSheet.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(viewBottomSheet)
        let topConstant : CGFloat = 230
        bottomSheetViewTopConstraint = viewBottomSheet.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
                NSLayoutConstraint.activate([
                    viewBottomSheet.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    viewBottomSheet.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    viewBottomSheet.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    bottomSheetViewTopConstraint,
                ])
        viewBottomSheet.layer.zPosition = 99
        view.addSubview(dragIndicatorView)
        dragIndicatorView.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(6)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(viewBottomSheet.snp.top).offset(12)
        }
        
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        view.addGestureRecognizer(viewPan)
    }
    func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
        guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) })
        else { return number }
        return nearestVal
    }
    // MARK: 랭킹뷰 보여주기
    private func showBottomSheet(atState: BottomSheetViewState = .normal) {
        if atState == .normal {
            let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding: CGFloat = view.safeAreaInsets.bottom
            bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
            UIView.animate(withDuration: 0.25) {
                let newFrame = CGRect(x: UIScreen.main.bounds.maxX/2 - 88, y: 33, width: 176, height: 36)
                self.control.frame = newFrame
            }
        } else {
            bottomSheetViewTopConstraint.constant = bottomSheetPanMinTopConstant
            UIView.animate(withDuration: 0.7) {
                let newFrame = CGRect(x: UIScreen.main.bounds.maxX/2 - 88, y: 72, width: 176, height: 36)
                self.control.frame = newFrame
            }
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    // MARK: 시트 숨기기
    private func hideBottomSheet() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint.constant = safeAreaHeight - 10
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
            self.ViewControllerRanking.view.alpha = 0
            self.ViewControllerMountain.view.alpha = 0
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @objc private func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: self.view)
            
        switch panGestureRecognizer.state {
            case .began:
                bottomSheetPanStartingTopConstant = bottomSheetViewTopConstraint.constant
            case .changed:
                if bottomSheetPanStartingTopConstant + translation.y > bottomSheetPanMinTopConstant {
                    bottomSheetViewTopConstraint.constant = bottomSheetPanStartingTopConstant + translation.y
                }
            case .ended:
                let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
                let bottomPadding = view.safeAreaInsets.bottom
                // 1
                let defaultPadding = safeAreaHeight+bottomPadding - defaultHeight
                
                // 2
                let nearestValue = nearest(to: bottomSheetViewTopConstraint.constant, inValues: [bottomSheetPanMinTopConstant, defaultPadding, safeAreaHeight + bottomPadding])
                
                // 3
                if nearestValue == bottomSheetPanMinTopConstant {
                    showBottomSheet(atState: .expanded)
                } else if nearestValue == defaultPadding {
                    // Bottom Sheet을 .normal 상태로 보여주기
                    showBottomSheet(atState: .normal)
                } else {
                    hideBottomSheet()
                }
            default:
                break
            }
    }
    //MARK: seguement Control
    @objc func segconChanged(_ sender : BetterSegmentedControl) {
        switch sender.index {
        case 0:
            UIView.animate(withDuration: 0.5) {
                self.ViewControllerRanking.view.alpha = 1
                self.ViewControllerMountain.view.alpha = 0
            }
        case 1:
            UIView.animate(withDuration: 0.5) {
                self.ViewControllerRanking.view.alpha = 0
                self.ViewControllerMountain.view.alpha = 1
            }
        default: return
        }
    }
    let control = BetterSegmentedControl(
        frame: CGRect(x: UIScreen.main.bounds.maxX/2 - 88 , y: 33, width: 176, height: 36),
        segments: LabelSegment.segments(withTitles: ["랭킹","산 정보"],
                                        normalFont: UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)!,
                                        normalTextColor: .titleColorGray,
                                        selectedFont: UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 16)!,
                                        selectedTextColor: .white),
        index: 0,
        options: [.backgroundColor(UIColor(hex: 0x7C909B, alpha: 0.15)),
                  .indicatorViewBackgroundColor(.mainColor),
                  .indicatorViewInset(4),
                  .animationDuration(0.5)
                  ])
    func seguecontrolSet() {
        control.indicatorView.layer.shadowColor = UIColor.mainColor.cgColor
        control.indicatorView.layer.shadowRadius = 18
        control.indicatorView.layer.shadowOpacity = 0.3
        control.indicatorView.layer.shadowOffset = CGSize(width: 0, height: 0)
        control.cornerRadius = 18
        control.addTarget(self, action: #selector(segconChanged(_:)), for: .valueChanged)
        viewBottomSheet.addSubview(control)
    }
}
extension RankingMountainViewController : UINavigationBarDelegate {
    
}
