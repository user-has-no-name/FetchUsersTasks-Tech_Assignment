//
//  NotificationCenterNames.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import Foundation

extension Notification.Name {

  static var idle: Notification.Name {
    return .init(rawValue: "UserListViewModel.IDLE")
  }

  static var fetchingFinished: Notification.Name {
    return .init(rawValue: "UserListViewModel.fetchingFinished")
  }

}
