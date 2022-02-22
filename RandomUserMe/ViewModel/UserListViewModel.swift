//
//  UserListViewModel.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import UIKit

final class UserListViewModel {

  private let notificationCenter: NotificationCenter
  private let services: Services

  var state = State.idle {
    didSet {stateDidChange()}
  }

  init(service: Services, notificationCenter: NotificationCenter = .default) {
    self.notificationCenter = notificationCenter
    self.services = service
  }

  var fetchedUsers: [UserWithAvatar]!

  /// Fetchs users
  func fetchUsers() {

    guard let url = Endpoint.api().url else { return }

    let urlRequest = services.networkService.makeURLRequest(with: url)

    services.networkService.fetch(urlRequest: urlRequest) {[weak self] (result: Result<Users, Error>)  in

      do {

        let users = try result.get()
        self?.fetchAvatars(users: users)

      } catch {
        print(error)
      }
    }
  }

  /// Fetchs avatar
  func fetchAvatars(users: Users) {

    var usersWithAvatars: [UserWithAvatar] = []

    let group = DispatchGroup()

    for user in users.results {

      group.enter()

      guard let url = URL(string: user.picture.thumbnail) else { return }

      services.networkService.fetchImage(url: url) { image in

        let userWithAvatar = UserWithAvatar(user: user, avatar: image)

        usersWithAvatars.append(userWithAvatar)
        group.leave()

      }
    }

    group.notify(queue: .main) {
      self.fetchedUsers = usersWithAvatars
      self.state = .fetched
    }

  }
}

extension UserListViewModel {

  enum State {
    case idle
    case fetched
  }

  func stateDidChange() {
      switch state {
      case .idle:
        notificationCenter.post(name: .idle, object: nil)
      case .fetched:
        guard let fetchedUsers = fetchedUsers else { return }

        // Sends notification to the Notification Center with fetched result
        notificationCenter.post(name: .fetchingFinished, object: self, userInfo: ["users": fetchedUsers])
      }
  }

}
