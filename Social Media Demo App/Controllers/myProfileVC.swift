//
//  myProfileVC.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 01/11/2023.
//

import UIKit
import NVActivityIndicatorView

class myProfileVC: UIViewController {
    
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var imageUrlTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       

    }
    
    func setupUI(){
        userImageView.makeCircularImage()
        if let user = UserManager.loggedInUser{
            if let image = user.picture{
                userImageView.convertFromStringUrlToUIImage(stringUri: image)
            }
            nameLabel.text = user.firstName + " " + user.lastName
            firstNameTextField.text = user.firstName
            lastNameTextField.text =  user.lastName
            phoneTextField.text = user.phone
            imageUrlTextField.text = user.picture
        }
    }
    
   
    
    @IBAction func confirmBtnClicked(_ sender: Any) {
        guard let user = UserManager.loggedInUser else{return}
        loaderView.startAnimating()
        UserDataAPI.shared.updateUserData(userId: user.id, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, phone: phoneTextField.text!, imageUrl: imageUrlTextField.text!) { response, error in
            self.loaderView.stopAnimating()
            if let userResponse = response{
                self.userImageView.convertFromStringUrlToUIImage(stringUri: userResponse.picture ?? "")
                self.nameLabel.text = userResponse.firstName + " " + userResponse.lastName
            }
        }
    }

}
