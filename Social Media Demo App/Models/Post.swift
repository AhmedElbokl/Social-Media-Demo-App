//
//  Post.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 19/10/2023.
//

import Foundation
import UIKit

struct Post: Codable {
    var id: String
    var image: String
    var likes: Int
    var text: String
    var owner: User
}

