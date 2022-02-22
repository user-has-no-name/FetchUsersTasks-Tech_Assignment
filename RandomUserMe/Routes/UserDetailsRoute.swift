//
//  UserDetailsRoute.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import UIKit

protocol UserDetailsRoute {
  func openUserDetails(for selectedUser: UserWithAvatar)
}

extension UserDetailsRoute where Self: UIViewController {

  func openUserDetails(for selectedUser: UserWithAvatar) {
    let userDetailsVC = UserDetailsViewController(selectedUser: selectedUser)
    navigationController?.pushViewController(userDetailsVC, animated: true)
  }
}

