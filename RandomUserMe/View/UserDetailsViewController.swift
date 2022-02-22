//
//  UserDetailsViewController.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//


import UIKit
import MapKit

final class UserDetailsViewController: UIViewController, MapVCRoute {

  var selectedUser: UserWithAvatar

  // Table View and its configuration
  private lazy var usersDetailsTableView: UITableView = {

    let table = UITableView(frame: CGRect(), style: .grouped)
    table.register(UserCell.self, forCellReuseIdentifier: Constants.userCellID)
    table.register(UserDetailsCell.self, forCellReuseIdentifier: Constants.userDetailsCellID)
    table.allowsSelection = false
    table.tableFooterView = tableFooter
    return table

  }()

  // Table footer with a button ShowMap inside and its configuration
  private lazy var tableFooter: UIView = {

    let customView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    customView.backgroundColor = UIColor.white

    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    button.setImage(UIImage(named: "mappin.and.ellipse"), for: .normal)
    button.imageView?.tintColor = .red

    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
    button.setTitle("Show on map", for: .normal)
    button.setTitleColor(.black, for: .normal)

    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    customView.addSubview(button)

    return customView

  }()

  init(selectedUser: UserWithAvatar) {
    self.selectedUser = selectedUser
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Handles a showMap button
  @objc func buttonAction(_ sender: UIButton!) {
    // Gets position
    guard let userPosition = userPosition() else { return }
    // Redirect to the MapViewController
    showMap(using: userPosition)
  }

  /// Returns Position model using coordinates from UserWithAvatar model
  /// Shouldn't be in here
  private func userPosition() -> Position? {

    let latitude = Double(selectedUser.user.location.coordinates.latitude)
    let longitude = Double(selectedUser.user.location.coordinates.longitude)

    if let latitude = latitude,
       let longitude = longitude {

      let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      let userPositions = Position(title: "User's position", coordinate: coordinates)

      return userPositions
    }

    return nil
  }

  override func viewDidLoad() {
    configUI()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    // Sets table view to the fullscreen
    usersDetailsTableView.frame = view.bounds
  }

  /// Configs UI:
  /// sets delegate and datasource for table view,
  /// sets background color for view
  /// adds tableView to the view as a subview
  private func configUI() {
    view.addSubview(usersDetailsTableView)

    usersDetailsTableView.dataSource = self
    usersDetailsTableView.delegate = self
    view.backgroundColor = .white
  }
}

// MARK: - Table View methods
extension UserDetailsViewController: UITableViewDataSource, UITableViewDelegate {

  /// Sets number of sections
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  /// Sets number of rows for sections
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      // For section with username and avatar
      return 1
    }
    // For the rest information
    return 4
  }

  /// Cells for rows
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    if indexPath.section == 0 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userCellID,
                                                     for: indexPath) as? UserCell else { return UITableViewCell() }

      cell.configCell(with: selectedUser)

      return cell

    } else {

      guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userDetailsCellID,
                                                     for: indexPath) as? UserDetailsCell
      else {
        return UITableViewCell()
      }

      if indexPath.row == 0 {
        cell.configUI(with: ["phone:": selectedUser.user.phone])
      } else if indexPath.row == 1 {
        cell.configUI(with: ["gender:": selectedUser.user.gender])
      } else if indexPath.row == 2 {
        cell.configUI(with: ["email:": selectedUser.user.email])
      } else if indexPath.row == 3 {
        cell.configUI(with: ["nationality:": selectedUser.user.nat])
      }

      return cell
    }
  }

  /// Sets cell's height
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 70
    } else {
      return 40
    }
  }
}
