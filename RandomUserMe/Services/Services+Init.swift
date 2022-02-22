//
//  Services+Init.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import Foundation

struct Services {
  let networkService: NetworkService
}

extension Services {

  init() {
    self.init(networkService: URLSession.shared)
  }

}

