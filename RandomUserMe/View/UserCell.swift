//
//  UserCell.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import UIKit

/// Class for cell with Username and user's avatar
final class UserCell: UITableViewCell {

  // Label for username with configuration
  private lazy var usernameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20.0)
    return label
  }()

  // User's avatar with configuration
  private lazy var avatar: UIImageView = {
    let imageView = UIImageView()

    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 18
    imageView.clipsToBounds = true

    return imageView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    avatar.translatesAutoresizingMaskIntoConstraints = false

    configCellUI()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Adds label and avatar as a subviews
  private func configCellUI() {

    contentView.addSubview(usernameLabel)
    contentView.addSubview(avatar)

    configConstraints()
  }

  /// Sets constrains for all subviews
  private func configConstraints() {
    NSLayoutConstraint.activate([
      usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      usernameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      avatar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      avatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      avatar.widthAnchor.constraint(equalToConstant: 60),
      avatar.heightAnchor.constraint(equalToConstant: 60)
    ])
  }

  /// Configs cell using data from UserWithAvatar model
  func configCell(with data: UserWithAvatar) {

    usernameLabel.text = data.user.name.first + " " + data.user.name.last
    avatar.image = data.avatar
  }
}
