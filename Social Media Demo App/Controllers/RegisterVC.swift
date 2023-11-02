//
//  RegisterVC.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 27/10/2023.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        UserDataAPI.shared.register(firstName: firstNameTextField.text ?? "", lastname: lastNameTextField.text ?? "", email: emailTextField.text ?? "") {user, errorMsg in
            if errorMsg != nil {
                let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
                
            }else{
                let alert = UIAlertController(title: "Success", message: "Success to Create user", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
// goto sign in
                    self.goToSignIn()
                }
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func goToSignInVC(_ sender: Any) {
       goToSignIn()
    }
    
    func goToSignIn(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = mainStoryboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        signInVC.modalPresentationStyle = .fullScreen
        self.present(signInVC, animated: true)
    }
    
}
