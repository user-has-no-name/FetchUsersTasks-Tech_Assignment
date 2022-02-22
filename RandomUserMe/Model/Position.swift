//
//  Position.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import UIKit
import MapKit

class Position: NSObject, MKAnnotation {

  var coordinate: CLLocationCoordinate2D
  var title: String?

  init(title: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.coordinate = coordinate
  }

}
