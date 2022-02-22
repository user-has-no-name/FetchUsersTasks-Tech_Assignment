//
//  Service+Mock.swift
//  RandomUserMeTests
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import Foundation
@testable import RandomUserMe

extension Services {
  static var mock: Services {
    Services(networkService: MockNetworkService())
  }
}
