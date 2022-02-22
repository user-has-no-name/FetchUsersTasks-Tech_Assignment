//
//  MockFixture.swift
//  RandomUserMeTests
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import Foundation

func mockFixture(name: String) -> Data {

  guard let mockFixtureURL = Bundle.main.url(forResource: name, withExtension: "json"),
        let data = try? Data(contentsOf: mockFixtureURL)
  else { fatalError("Mock fixture \(name) not found.") }

  return data
}
