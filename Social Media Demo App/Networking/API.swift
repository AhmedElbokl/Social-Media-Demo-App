//
//  API.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 27/10/2023.
//

import Foundation
import Alamofire

class API {
    let baseUrl = "https://dummyapi.io/data/v1"
    static let appId = "6541965672ea8ae798d95d2e" /*"6531535fe8ca784faf33486e"*/
    
    let headers: HTTPHeaders = [
        "app-id" : appId
    ]
}
