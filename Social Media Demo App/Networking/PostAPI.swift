//
//  PostAPI.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 27/10/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostAPI: API {
    static let shared = PostAPI()
    
//    let baseUrl = "https://dummyapi.io/data/v1"
//    static let appId = "6531535fe8ca784faf33486e"
//    let headers: HTTPHeaders = [
//        "app-id" : appId
//    ]
//
    func requestPosts(completionHandler: @escaping ([Post]) -> ()) {
        let url = baseUrl + "/post"
        
        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode([Post].self, from: data.rawData())
                completionHandler(decodedData)
            } catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    func requestPostComments(postId: String, completionHandler: @escaping ([Comment]) -> ()){
        let url = baseUrl + "/post/\(postId)/comment"
    
        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
                let decoder = JSONDecoder()
                do{
                    let decodedData = try decoder.decode([Comment].self, from: data.rawData())
                    completionHandler(decodedData)
                } catch let error{
                    print(error.localizedDescription)
                }
        }
    }
}
