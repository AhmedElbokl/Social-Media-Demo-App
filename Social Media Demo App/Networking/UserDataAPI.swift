//
//  UserAPI.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 27/10/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserDataAPI: API{
    static let shared = UserDataAPI()
    
    func userDataRequest(userId: String, completionHandler: @escaping (User) -> ()){
        let url = baseUrl + "/user/\(userId)"
        
        
        AF.request(url, headers: headers).responseJSON {response in
            let jsonData = JSON(response.value)
            print(jsonData)
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(User.self, from: jsonData.rawData())
                completionHandler(decodedData)
            }catch let erorr {
                print(erorr.localizedDescription)
            }
        }
    }
    
    func register(firstName: String, lastname: String, email: String, completionHandler: @escaping (User?, String?) -> ()){
        let url = baseUrl + "/user/create"
        let bodyPram = [
            "firstName": firstName,
            "lastName": lastname,
            "email": email
        ]
        
        AF.request(url, method: .post, parameters: bodyPram, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON {response in
            switch response.result {
            case .success:
                let jsonData = JSON(response.value)
                print(jsonData)
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(decodedData, nil)
                }catch let erorr {
                    print(erorr.localizedDescription)
                }
            case  .failure:
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let emailError = data["email"].stringValue
                let errorCatched = firstNameError + " " + lastNameError + "  " + emailError
                completionHandler(nil, errorCatched)
            }
        }
    }
    
    func confirmSignIn(firstName: String, lastName: String, completionHandler: @escaping (User?, String?) -> ()){
        let url = baseUrl + "/user"
        let params = ["created": "1"]
        
        
        AF.request(url, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: headers).validate()
            .responseJSON {response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.value)
                    print(jsonData)
                    let data = jsonData["data"]
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode([User].self, from: data.rawData())
                        var foundUser: User?
                        for user in decodedData {
                            if user.firstName == firstName && user.lastName == lastName {
                                foundUser = user
                                break
                            }
                        }
                        
                        if let user = foundUser {
                            completionHandler(user, nil)
                        }else {
                            completionHandler(nil, "Wrong Sign In Data")
                        }

                        print(decodedData)
                    }catch let erorr {
                        print(erorr.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}

