//
//  UserListViewModelTests.swift
//  RandomUserMeTests
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import XCTest
@testable import RandomUserMe

class RandomUserTests: XCTestCase {

  private var sut: UserListViewModel!

  override func setUp() {
      super.setUp()

    sut = UserListViewModel(service: .mock)
  }

  override func tearDown() {
      sut = nil

      super.tearDown()
  }

  func testEndpoint() {
    XCTAssertNotNil(Endpoint.api().url)
  }

  func testInit() {
    let viewModel = UserListViewModel(service: .init())

    XCTAssertNil(viewModel.fetchedUsers)
    XCTAssertEqual(viewModel.state, .idle)

  }

  func testNotification() {

    let notificationExpectation = expectation(forNotification: .fetchingFinished,
                                              object: sut) { notification in

      guard let users = notification.userInfo?["users"] as? [UserWithAvatar] else { return false }

      XCTAssertTrue(!users.isEmpty)

      return true

    }

    sut.fetchUsers()
    wait(for: [notificationExpectation], timeout: 20)

    }

}
