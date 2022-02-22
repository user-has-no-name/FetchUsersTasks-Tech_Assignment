//
//  Mock+NetworkService.swift
//  RandomUserMeTests
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import Foundation
@testable import RandomUserMe

final class MockNetworkService: NetworkService {

  func makeURLRequest(with url: URL) -> URLRequest {
    URLRequest(url: url)
  }

  func fetch<T>(urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {

    guard let url = urlRequest.url else { return }

    switch url {
    case Endpoint.api().url:

      let usersFixture: T? = try? JSONDecoder().decode(T.self, from: mockFixture(name: "users"))

      if let usersFixture = usersFixture {
//        NotificationCenter.default.post(name: .fetchingFinished, object: self)
        completion(.success(usersFixture))
      }
    default:
      break
    }

  }
}

