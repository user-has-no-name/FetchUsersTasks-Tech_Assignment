//
//  UsersListViewController.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import UIKit

class UsersListViewController: UIViewController, UserDetailsRoute {

  // Table View with configuration
  private lazy var usersList: UITableView = {
    let tableView = UITableView()
    tableView.register(UserCell.self, forCellReuseIdentifier: Constants.userCellID)
    tableView.rowHeight = 75
    tableView.refreshControl = refreshControl
    return tableView
  }()

  // Refresh Control with configuration (Pull to refresh)
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshUsers(_:)), for: .valueChanged)
    refreshControl.attributedTitle = NSAttributedString(string: "Fetching Users ...")
    return refreshControl
  }()

  private var userListViewModel: UserListViewModel
  private var randomUsers: [UserWithAvatar]!
  private var notificationCenter: NotificationCenter

  init(userListViewModel: UserListViewModel, notificationCenter: NotificationCenter = .default) {

    self.notificationCenter = notificationCenter
    self.userListViewModel = userListViewModel

    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Adds observer whenever this viewDidLoad
    addViewModelObserver()

    // Calls a method from userListViewModel to fetch random users
    userListViewModel.fetchUsers()

    // Delegate and datasource config
    usersList.delegate = self
    usersList.dataSource = self

    configUI()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    // Sets table view to the full screen
    usersList.frame = view.bounds
  }

  /// Add observer to the notification center
  private func addViewModelObserver() {

    /// Whenever it gets a notification
    /// didRecieveDataUpdate method calls
    notificationCenter.addObserver(self,
                                   selector: #selector(didRecieveDataUpdate(_:)),
                                   name: .fetchingFinished,
                                   object: nil)

  }

  /// Configs UI:
  /// sets title, sets background color
  /// and addSubview
  private func configUI() {

    self.title = "Random Users"
    self.view.backgroundColor = .white

    view.addSubview(usersList)

  }

  /// Fetchs users from UserListViewModel and handles it
  @objc private func didRecieveDataUpdate(_ notification: Notification) {

    guard let users = notification.userInfo?["users"] as? [UserWithAvatar] else { return }

    self.randomUsers = users

    // Reloads table view
    usersList.reloadData()
    self.refreshControl.endRefreshing()
  }

  /// Method for a pull to refresh
  @objc private func refreshUsers(_ sender: Any) {
    userListViewModel.fetchUsers()
  }

}

// MARK: - TableView Methods
extension UsersListViewController: UITableViewDelegate,
                       UITableViewDataSource {

  /// Number of rows
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    guard let randomUsers = randomUsers else { return 0 }

    return randomUsers.count

  }

  /// Cell for row at specific index
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userCellID,
                                                   for: indexPath) as? UserCell
    else {
      return UITableViewCell()
    }

    cell.configCell(with: randomUsers[indexPath.row])

    return cell
  }

  /// Handles selecting of row
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    // Selected specific user from all users
    let selectedUser = randomUsers[indexPath.row]

    // Redirects to the UserDetailsViewController using UserDetailsRoute method
    openUserDetails(for: selectedUser)
  }

}
