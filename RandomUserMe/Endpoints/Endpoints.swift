//
//  Endpoints.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import Foundation

struct Endpoint {
  let host: String
  let path: String
  let queryItems: [URLQueryItem]
}

extension Endpoint {
  var url: URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path
    components.queryItems = queryItems
    return components.url
  }
}

extension Endpoint {
  static func api() -> Self {
    .init(host: "randomuser.me", path: "/api", queryItems: [
      URLQueryItem(name: "results", value: "10"),
      URLQueryItem(name: "inc", value: "gender,name,nat,location,email,phone,picture")
    ])
  }

}
