//
//  NetworkService.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import UIKit

protocol NetworkService {
  func makeURLRequest(with url: URL) -> URLRequest
  func fetch<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}

extension NetworkService {

  func fetch<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {

    URLSession.shared.dataTask(with: urlRequest) { data, _, error in

      do {
        if let error = error {
          completion(.failure(error))
          return
        }
        guard let data = data else { preconditionFailure("No error was received but we also don't have data...")}

        let decodedObject = try JSONDecoder().decode(T.self, from: data)

        completion(.success(decodedObject))

      } catch {
        completion(.failure(error))
      }

    }.resume()
  }

  func fetchImage(url: URL, completion: @escaping (UIImage) -> Void) {

    URLSession.shared.dataTask(with: url) { data, _, error in

      if let error = error {
         print(error)
      }

      guard let data = data else { return }

      if let image = UIImage(data: data) {
        completion(image)
      }
    }.resume()
  }
}

extension URLSession: NetworkService {

  func makeURLRequest(with url: URL) -> URLRequest {
    URLRequest(url: url)
  }

}

