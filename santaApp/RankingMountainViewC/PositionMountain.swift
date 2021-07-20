//
//  PositionMountain.swift
//  santaApp
//
//  Created by 노영재 on 2021/07/20.
//

import UIKit
import MapKit

class PositionMountain: NSObject, MKAnnotation {
    @objc dynamic var coordinate = CLLocationCoordinate2D(latitude: 37.779_379, longitude: -122.418_433)

    // Required if you set the annotation view's `canShowCallout` property to `true`
     var title: String? = NSLocalizedString("PositionMountain", comment: "SF annotation")
     
     // This property defined by `MKAnnotation` is not required.
     var subtitle: String? = NSLocalizedString("PositionMountain", comment: "SF annotation")
}
