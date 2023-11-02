//
//  NewPostVC.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 01/11/2023.
//

import UIKit
import NVActivityIndicatorView

class NewPostVC: UIViewController {

    @IBOutlet weak var postTextField: UITextField!
    @IBOutlet weak var postImageTextField: UITextField!
    
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeBtnClicked(_ sender: Any) {
        // go to PostsVC
        
        self.dismiss(animated: true)
    }
    
    @IBAction func addPostBtnClicked(_ sender: Any) {
        loaderView.startAnimating()
        if let user = UserManager.loggedInUser{
            PostAPI.shared.addPost(userId: user.id, postText: postTextField.text!, postImage: postImageTextField.text!) {
                self.loaderView.stopAnimating()
                NotificationCenter.default.post(name: NSNotification.Name("newPostAdded"), object: nil)
                self.dismiss(animated: true)
            }
        }
    }
    

}
