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
    func requestPosts(page: Int, tag: String?,completionHandler: @escaping ([Post], Int) -> ()) {
        var url = baseUrl + "/post"
        if let tag = tag {
            let cleanTag = tag.trimmingCharacters(in: .whitespaces)
            url = baseUrl + "/tag/\(cleanTag)/post"
        }
        print(url)
        let pram = ["limit": "\(5)",
                    "page": "\(page)"
        ]
        AF.request(url,parameters: pram, encoder: URLEncodedFormParameterEncoder.default,
                   headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let total = jsonData["total"].intValue
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode([Post].self, from: data.rawData())
                completionHandler(decodedData, total)
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
    
    func addComment(commentMsg: String, userId: String, postId: String, completionHandler: @escaping () -> ()){
        let url = baseUrl + "/comment/create"
        let bodyPram = [
            "message": commentMsg,
            "owner": userId,
            "post": postId
        ]
        AF.request(url, method: .post,parameters: bodyPram,encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success: print("")
                completionHandler()
                
            case .failure(let error): print(error)
            }
        }
    }
    
// tags request
    
    func requestTags(completionHandler: @escaping ([String?]) -> ()) {
        let url = baseUrl + "/tag"
        
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode([String?].self, from: data.rawData())
                print(decodedData)
                completionHandler(decodedData)
            } catch let error {
                print(error)
            }
            print(data)
        }
    }
    
    // create new post
    
    func addPost(userId: String, postText: String, postImage: String, completionHandelr: @escaping () -> ()){
        
        let url = baseUrl + "/post/create"
        let bodyPram = [
            "owner": userId,
            "text": postText,
            "image": postImage
        ]
        
        AF.request(url, method: .post, parameters: bodyPram, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                completionHandelr()
            case .failure(let error):
                print(error)
            }        }
    }
  
}
