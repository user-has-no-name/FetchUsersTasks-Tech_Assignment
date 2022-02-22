//
//  AppDelegate.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


  var window: UIWindow?

  let userViewModel = UserListViewModel(service: .init())

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)

    let navigationController = UINavigationController()
    let rootViewController = UsersListViewController(userListViewModel: userViewModel)

    navigationController.viewControllers = [rootViewController]

    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()

    return true

  }

}

