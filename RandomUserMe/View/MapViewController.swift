//
//  MapViewController.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

  private var mapView: MKMapView!
  var userPosition: Position

  init(userPosition: Position) {
    self.userPosition = userPosition
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configMapView()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    mapView.frame = view.bounds
  }

  /// Configs a map view
  func configMapView() {
    mapView = MKMapView()
    view.addSubview(mapView)

    mapView.addAnnotation(userPosition)
    mapView.centerCoordinate = userPosition.coordinate
  }

}
