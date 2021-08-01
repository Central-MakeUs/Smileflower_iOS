//
//  FlagMapViewController.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/23.
//

import UIKit
import MapKit
class FlagMapViewController : UIViewController {
    var useridx : Int?
    var mountainFlagResult : [FlagMountainResponse] = []
    override func viewDidLoad() {
        if let idx = useridx {
            FlagMountainDataManager().apiprofileuserIdxflagsmap(self, idx)
        }
        super.viewDidLoad()
        view.backgroundColor = .white
        setMapView()
        setNavigationBar()
    }
    // MARK: navigationBar
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(actionBackButton(_:)))
        button.tag = 1
        button.tintColor = .titleColorGray
        return button
        
    }()
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(actionGoExplain))
        button.tag = 2
        button.tintColor = .titleColorGray
        return button
        
    }()
    let viewNavBack = UIView()
    func setNavigationBar() {
        let height: CGFloat = 30
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.clear
        navbar.delegate = self
        viewNavBack.backgroundColor = .white

        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = self.leftButton
        navItem.rightBarButtonItem = self.rightButton
        navbar.items = [navItem]
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.layoutIfNeeded()
        navbar.topItem?.title = "정복한 산"
        view.addSubview(viewNavBack)
        viewNavBack.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.height.equalTo(93)
        }
        view.addSubview(navbar)
    }
    @objc func actionBackButton(_ sender : Any) {
        let nextVC = BaseTabbarController()
        nextVC.index = 3
        self.changeRootViewController(nextVC)
    }
    @objc func actionGoExplain() {
        let ShowVC = FlagExplainViewController()
        ShowVC.modalPresentationStyle = .overFullScreen
        self.present(ShowVC, animated: false, completion: nil)
    }
    //MARK: Map 뷰 만들기
    let mapView = MKMapView()
    func setMapView() {
        mapView.delegate = self
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        mapView.register(FlagMKAnnotionView.self, forAnnotationViewWithReuseIdentifier: FlagMKAnnotionView.identifier)
    }
    //MARK: 맵 뷰 포인트 찍기
    func goLocation(latitudeValue: CLLocationDegrees,
                        longtudeValue: CLLocationDegrees,
                        delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
            let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
            let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        let showLocation = CLLocationCoordinate2DMake(latitudeValue - 0.016, longtudeValue)
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
}

extension FlagMapViewController : MKMapViewDelegate, UINavigationBarDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        for i in mountainFlagResult {
            if annotation.title == i.mountainName {
                guard let annotation1 = mapView.dequeueReusableAnnotationView(withIdentifier: FlagMKAnnotionView.identifier) as? FlagMKAnnotionView
                else {
                    fatalError("cant dequeue annotaition")
                    }
                if let counts = i.flagCount {
                    if counts < 4 {
                        annotation1.image = UIImage(named: "illustMapFlag1Small@3x")
                    }
                    else if counts < 7 {
                        annotation1.image = UIImage(named: "illustMapFlag2Small@3x")
                    }
                    else {
                        annotation1.image = UIImage(named: "illustMapFlag3Small@3x")
                    }
                }
                return annotation1
            }
        }
        return MKAnnotationView()
    }
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        for i in mountainFlagResult {
//            if view.annotation?.title == i.mountainName {
//                print("click")
//                view.frame = CGRect(x: 0, y: 0, width: 60, height: 88.5)
//            }
//        }
//    }
}

extension FlagMapViewController {
    func successDataApi(_ result : [FlagMountainResponse]) {
        mountainFlagResult = result
        for i in result {
            if let lat = i.latitude, let long = i.longitude, let title = i.mountainName {
                self.setAnnotation(latitudeValue: lat, longitudeValue: long, span: 3.5, title: title)
            }
        }
    }
}
