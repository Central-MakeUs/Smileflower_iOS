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
    var mountainIndex : Int?
    var latitude : Double?
    var longitude : Double?
    var mountainName : String = ""
    var mountainPosition : MapPositionMountain?
    var mountainCoursePosition : [MapPositionRoad] = []
    // MARK: 내용View 만들기.
    private let ViewControllerRanking : ContentRankViewController
    private let ViewControllerMountain : ContentMountainViewController
    
    init(contentRankingViewController: ContentRankViewController,
         contentMountainViewController : ContentMountainViewController) {
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
        
        if let idx = mountainIndex {
            MapPositionDataManager().appmountainsmountainIdxmap(self, idx)
        }
        mapViewSet()
        navigationBarSet()
        viewSetBottomSheet()
        seguecontrolSet()
        setupMiddleButton(CGRect(x: view.bounds.width - 109.1,
                                 y: view.bounds.height - 129.1,
                                 width: 79.1, height: 79.1))
        
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
        mapView.mapType = .mutedStandard
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mapView.register(PositionMountainAnnotationView.self, forAnnotationViewWithReuseIdentifier: PositionMountainAnnotationView.identifier)
        mapView.register(PositionCourseAnnotationView.self, forAnnotationViewWithReuseIdentifier: PositionCourseAnnotationView.identifier)
    }
    func goLocation(latitudeValue: CLLocationDegrees,
                        longtudeValue: CLLocationDegrees,
                        delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
            let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
            let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        let showLocation = CLLocationCoordinate2DMake(latitudeValue - 0.059, longtudeValue)
        let showspanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let showRegion = MKCoordinateRegion(center: showLocation, span: showspanValue)
            mapView.setRegion(pRegion, animated: true)
        mapView.setRegion(showRegion, animated: true)
            return pLocation
    }
    func setAnnotation(latitudeValue: CLLocationDegrees,
                       longitudeValue: CLLocationDegrees,
                   span : Double,
                   title : String) {
        let annotaion = MKPointAnnotation()
        annotaion.title = title
        annotaion.coordinate = goLocation(latitudeValue: latitudeValue, longtudeValue: longitudeValue, delta: span)
        mapView.addAnnotation(annotaion)
    }
    // MARK: 버튼 구현
    let menuButton = UIButton()
    func setupMiddleButton(_ originFrame : CGRect) {
        menuButton.frame = originFrame
           menuButton.backgroundColor = UIColor.mainColor
        menuButton.layer.cornerRadius = 39.55
        menuButton.layer.shadowColor = UIColor.mainColor.cgColor
        menuButton.layer.shadowOpacity = 0.3
        menuButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        menuButton.layer.shadowRadius = 18
           view.addSubview(menuButton)

           menuButton.setImage(UIImage(named: "FlagIcon@3x"), for: .normal)
        menuButton.imageEdgeInsets = UIEdgeInsets(top: 1.6, left: 2.15, bottom: -1.6, right: -2.15)
           menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

        menuButton.layer.zPosition = 999
           view.layoutIfNeeded()
       }
    @objc private func menuButtonAction(sender: UIButton) {
        let nextVC = StartViewController()
        nextVC.labelMountainName.text = mountainName
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true, completion: nil)
    }
    // MARK: 아래 시트 구현
    func viewSetBottomSheet() {
        addChild(ViewControllerRanking)
        addChild(ViewControllerMountain)
        viewBottomSheet.addSubview(ViewControllerRanking.view)
        if let idx = mountainIndex {
            MountainRankingDataManager().appmountainsmountainIdxrank(ViewControllerRanking.self, idx)
            MountainInfoDataManager().appmountiansmountainIdxinfo(ViewControllerMountain.self, idx)
            ViewControllerMountain.mountainIdx = idx
        }
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
        view.addSubview(viewBottomSheet)
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
                self.control.alpha = 1
                if self.control.index == 0 {
                    self.ViewControllerRanking.view.alpha = 1
                }
                else {
                    self.ViewControllerMountain.view.alpha = 1
                }
                let newFrame = CGRect(x: UIScreen.main.bounds.maxX/2 - 88, y: 33, width: 176, height: 36)
                self.control.frame = newFrame
            }
        } else {
            bottomSheetViewTopConstraint.constant = bottomSheetPanMinTopConstant
            UIView.animate(withDuration: 0.25) {
                self.control.alpha = 1
                if self.control.index == 0 {
                    self.ViewControllerRanking.view.alpha = 1
                }
                else {
                    self.ViewControllerMountain.view.alpha = 1
                }
                let newFrame = CGRect(x: UIScreen.main.bounds.maxX/2 - 88, y: 72, width: 176, height: 36)
                self.control.frame = newFrame
            }
        }
        self.viewMountainCourseClick.removeFromSuperview()
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
            self.menuButton.frame = CGRect(x: self.view.bounds.width - 109.1, y: self.view.bounds.height - 129.1, width: 79.1, height: 79.1)

    
        }, completion: nil)
    }
    // MARK: 시트 숨기기
    private func hideBottomSheet() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint.constant = safeAreaHeight - 30
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
            self.control.alpha = 0
            if self.control.index == 0 {
                self.ViewControllerRanking.view.alpha = 0
            }
            else {
                self.ViewControllerMountain.view.alpha = 0
            }
        }) { _ in
            if self.presentingViewController != nil {
//                self.dismiss(animated: false, completion: nil)
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
    // MARK: 산 핀포인트 클릭시 나오는 뷰
    let viewMountainCourseClick : UIView = {
        let viewContent = UIView(frame: CGRect(x: UIScreen.main.bounds.width/2 - 171.5, y: UIScreen.main.bounds.height - 241, width: 343, height: 165))
        viewContent.backgroundColor = .clear
        return viewContent
    }()
    // MARK: 코스 디테일 뷰 꾸며주기
    func setViewMountainCourse(_ contentView : UIView,
                               _ courseTime : String,
                               _ courseDistance : String,
                               _ courseNum : String,
                               _ courseDifficulty : Int,
                               _ courseDetail : String) {
        // MARK: 코스 선택시 위에 나타나는 시간과 거리 뷰 구현
        let viewTimeAndDistance = UIView()
        viewTimeAndDistance.backgroundColor = .white
        viewTimeAndDistance.layer.cornerRadius = 17
        viewTimeAndDistance.layer.shadowRadius = 10
        viewTimeAndDistance.layer.shadowColor = UIColor.bluegray.cgColor
        contentView.addSubview(viewTimeAndDistance)
        viewTimeAndDistance.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView)
            make.width.equalTo(175)
            make.height.equalTo(34)
        }
        let imageViewRun = UIImageView()
        imageViewRun.contentMode = .scaleAspectFit
        imageViewRun.image = UIImage(named: "icInfoDistanceSmall@3x")
        viewTimeAndDistance.addSubview(imageViewRun)
        imageViewRun.snp.makeConstraints { make in
            make.leading.equalTo(viewTimeAndDistance.snp.leading).offset(18)
            make.centerY.equalTo(viewTimeAndDistance.snp.centerY)
            make.width.equalTo(13.4)
            make.height.equalTo(11.3)
        }
        let labelDistanse = UILabel()
        labelDistanse.text = courseDistance
        labelDistanse.textColor = .mainColor
        labelDistanse.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 15)
        viewTimeAndDistance.addSubview(labelDistanse)
        labelDistanse.snp.makeConstraints { make in
            make.centerY.equalTo(viewTimeAndDistance)
            make.leading.equalTo(imageViewRun.snp.trailing).offset(4.7)
            make.width.equalTo(46)
        }
        let imageViewTime = UIImageView()
        imageViewTime.contentMode = .scaleAspectFit
        imageViewTime.image = UIImage(named: "icInfoTimeSmall@3x")
        viewTimeAndDistance.addSubview(imageViewTime)
        imageViewTime.snp.makeConstraints { make in
            make.leading.equalTo(labelDistanse.snp.trailing).offset(7.8)
            make.centerY.equalTo(viewTimeAndDistance)
            make.width.height.equalTo(12.4)
        }
        let labelTime = UILabel()
        labelTime.text = courseTime
        labelTime.textColor = .mainColor
        labelTime.font = UIFont(name: Constant.fontAppleSDGothicNeoMedium, size: 15)
        viewTimeAndDistance.addSubview(labelTime)
        labelTime.snp.makeConstraints { make in
            make.centerY.equalTo(viewTimeAndDistance)
            make.leading.equalTo(imageViewTime.snp.trailing).offset(4.7)
        }
        //MARK: 코스 디테일 뷰 구현
        let viewDetail = UIView()
        viewDetail.backgroundColor = .white
        viewDetail.layer.cornerRadius = 24
        viewDetail.layer.shadowRadius = 10
        viewDetail.layer.shadowColor = UIColor.bluegray.cgColor
        contentView.addSubview(viewDetail)
        viewDetail.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(contentView)
            make.top.equalTo(viewTimeAndDistance.snp.bottom).offset(9)
        }
        let labelCourseNum = UILabel()
        labelCourseNum.text = courseNum
        labelCourseNum.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 36)
        viewDetail.addSubview(labelCourseNum)
        labelCourseNum.snp.makeConstraints { make in
            make.top.equalTo(viewDetail).offset(13.5)
            make.leading.equalTo(viewDetail).offset(24)
        }
        let imageViewDifficulty = UIImageView()
        imageViewDifficulty.contentMode = .scaleAspectFit
        if courseDifficulty == 1 {
            imageViewDifficulty.image = UIImage(named: "illustInfo1@3x")
        }
        else if courseDifficulty == 2 {
            imageViewDifficulty.image = UIImage(named: "illustInfo2@3x")
        }
        else if courseDifficulty == 3 {
            imageViewDifficulty.image = UIImage(named: "illustInfo3@3x")
        }
        else if courseDifficulty == 4 {
            imageViewDifficulty.image = UIImage(named: "illustInfo4@3x")
        }
        else {
            imageViewDifficulty.image = UIImage(named: "illustInfo5@3x")
        }
        viewDetail.addSubview(imageViewDifficulty)
        imageViewDifficulty.snp.makeConstraints { make in
            make.centerY.equalTo(labelCourseNum.snp.centerY)
            make.leading.equalTo(labelCourseNum.snp.trailing).offset(9.9)
            make.width.equalTo(106.7)
            make.height.equalTo(18.8)
        }
        let labelCourseDetail = UILabel()
        labelCourseDetail.text = courseDetail
        labelCourseDetail.numberOfLines = 2
        labelCourseDetail.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 15)
        labelCourseDetail.textColor = .darkbluegray
        viewDetail.addSubview(labelCourseDetail)
        labelCourseDetail.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(labelCourseNum.snp.bottom).offset(11.5)
            make.width.equalTo(293)
        }
    }
}
extension RankingMountainViewController : UINavigationBarDelegate, MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.title == mountainName {
            guard let annotation1 = mapView.dequeueReusableAnnotationView(withIdentifier: PositionMountainAnnotationView.identifier) as? PositionMountainAnnotationView
            else {
                fatalError("cant dequeue annotaition")
                }
            
            annotation1.labelMountainName.text = mountainName
            return annotation1
        }
        for i in mountainCoursePosition {
            if annotation.title == i.courseNum {
                guard let annotation1 = mapView.dequeueReusableAnnotationView(withIdentifier: PositionCourseAnnotationView.identifier) as? PositionCourseAnnotationView
                else {
                    fatalError("cant dequeue annotaition")
                    }
                annotation1.labelCourseName.text = i.courseNum
                
                return annotation1
            }
        }
        return MKAnnotationView()
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        viewMountainCourseClick.removeFromSuperview()
        if view == PositionMountainAnnotationView() {
            
        }
        else {
            for i in mountainCoursePosition {
                if view.annotation?.title == i.courseNum {
                    mapView.addSubview(viewMountainCourseClick)
                    setViewMountainCourse(viewMountainCourseClick, i.time!, i.length ?? "-", i.courseNum!, i.difficulty!, i.course!)
                }
            }
        }
        self.hideBottomSheet()
        UIView.animate(withDuration: 0.2) {
            self.menuButton.frame = CGRect(x: self.view.bounds.width - 109.1, y: self.view.bounds.height - 301.1, width: 79.1, height: 79.1)
        }
    }
}

extension RankingMountainViewController {
    func successDataMountainPosition(_ result : MapPositionResult) {
        mountainPosition = result.mountain!
        mountainCoursePosition = result.road!
        
        for i in mountainCoursePosition {
            if let lat = i.latitude, let long = i.longitude, let course = i.courseNum {
                setAnnotation(latitudeValue: lat, longitudeValue: long, span: 0.1, title: course)
            }
        }
        
        if let lat = mountainPosition?.latitude , let long = mountainPosition?.longitude {
            setAnnotation(latitudeValue: lat, longitudeValue: long, span: 0.1, title: mountainName)
        }
    }
    func failureDataMountainPosition() {
        presentAlert(title: "네트워크 연결 장애")
    }
}
