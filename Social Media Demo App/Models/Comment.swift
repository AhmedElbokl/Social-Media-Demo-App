//
//  Comment.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 22/10/2023.
//

import Foundation
import UIKit

struct Comment: Codable{
    var id: String
    var message: String
    var owner: User
    
}
