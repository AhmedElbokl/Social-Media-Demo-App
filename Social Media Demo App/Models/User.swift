//
//  User.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 21/10/2023.
//

import Foundation
import UIKit

struct User: Codable {
    var id: String
    var firstName: String
    var lastName: String
    var picture: String?
    var phone: String?
    var email: String?
    var gender: String?
    var location: UserLocation?
}
