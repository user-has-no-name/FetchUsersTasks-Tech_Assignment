//
//  MapVCRoute.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import UIKit

protocol MapVCRoute where Self: UIViewController {
  func showMap(using userPosition: Position)
}

extension MapVCRoute {
  func showMap(using userPosition: Position) {

    let mapVC = MapViewController(userPosition: userPosition)

    navigationController?.pushViewController(mapVC, animated: true)
  }
}
