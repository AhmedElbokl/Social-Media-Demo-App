//
//  SignInVC.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 27/10/2023.
//

import UIKit

class SignInVC: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SignInBtnClicked(_ sender: Any) {
        UserDataAPI.shared.confirmSignIn(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!) { userResponse, error in
            if userResponse != nil {
                // go to PostsVC
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let postsVC = mainStoryboard.instantiateViewController(withIdentifier: "PostsVC") as! PostsVC
                postsVC.user = userResponse
                postsVC.modalPresentationStyle = .fullScreen
                self.present(postsVC, animated: true)
            }else{
                let alert = UIAlertController(title: "Error", message: error!, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func skipBtnClicked(_ sender: Any) {
        // go to PostsVC
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let postsVC = mainStoryboard.instantiateViewController(withIdentifier: "PostsVC") as! PostsVC
        postsVC.modalPresentationStyle = .fullScreen
        self.present(postsVC, animated: true)
    }
    
    @IBAction func goToRegisterVC(_ sender: Any) {
//        // go to PostsVC
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let registerVC = mainStoryboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
//        registerVC.modalPresentationStyle = .fullScreen
//        self.present(registerVC, animated: true)
        self.dismiss(animated: true)
    }
    
}








