//
//  User.swift
//  RandomUserMe
//
//  Created by Oleksandr Zavazhenko on 10/02/2022.
//

import Foundation
import UIKit

struct UserWithAvatar {
  var user: User
  var avatar: UIImage
}

struct Users: Codable {
  var results: [User]
}

struct User: Codable {
  var name: Name
  var gender: String
  var location: Location
  var phone: String
  var nat: String
  var picture: Picture
  var email: String
}

struct Name: Codable {
  var first: String
  var last: String
}

struct Location: Codable {
  var coordinates: Coordinates
}

struct Coordinates: Codable {
  var latitude: String
  var longitude: String
}

struct Picture: Codable {
  var thumbnail: String
}
