//
//  ProfileVC.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 26/10/2023.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileVC: UIViewController {
    var user: User?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = user else {return}
        setupUI()
        UserDataAPI.shared.userDataRequest(userId: user.id) { userResponse in
            self.user = userResponse
            self.setupUI()
        }
//        let url = "https://dummyapi.io/data/v1/user/\(user.id)"
//
//        let appId = "6531535fe8ca784faf33486e"
//        let headers: HTTPHeaders = [
//            "app-id": appId
//        ]
//
//        AF.request(url, headers: headers).responseJSON {response in
//            let jsonData = JSON(response.value)
//            print(jsonData)
//            //let data = jsonData["data"]
//            let decoder = JSONDecoder()
//            do {
//                let decodedData = try decoder.decode(User.self, from: jsonData.rawData())
//                self.user = decodedData
//            }catch let erorr {
//                print(erorr.localizedDescription)
//            }
//            self.setupUI()
//                }
    }
    

    func setupUI(){
        guard let user = user else {return}
        nameLabel.text = user.firstName + " " + user.lastName
        profileImageView.convertFromStringUrlToUIImage(stringUri: user.picture ?? "")
        profileImageView.makeCircularImage()
        phoneLabel.text = user.phone
        emailLabel.text = user.email
        genderLabel.text = user.gender
        guard let location = user.location else {return}
        addressLabel.text = location.street + " " + location.city + " " + location.state + " " + location.country
    }

}
