//
//  UserDetailsCell.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import UIKit

final class UserDetailsCell: UITableViewCell {

  // Title label
  private lazy var titleLabel = UILabel()

  // Content label and its config
  private lazy var contentLabel: UILabel = {
    let contentLabel = UILabel()
    contentLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    return contentLabel
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configUI()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configUI() {

    contentView.addSubview(titleLabel)
    contentView.addSubview(contentLabel)

    contentLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    setConstraints()

  }

  /// Sets constraints for all elements
  private func setConstraints() {

    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

      contentLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
      contentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])

  }

  /// Configs cell's UI content
   func configUI(with data: [String: String]) {

    if let titleLabel = data.keys.first,
       let contentLabel = data.values.first {

      self.titleLabel.text = titleLabel
      self.contentLabel.text = contentLabel

    }
  }

}
