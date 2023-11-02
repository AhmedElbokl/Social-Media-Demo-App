//
//  SignInVC.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 27/10/2023.
//

import UIKit
import Spring
import NVActivityIndicatorView

class SignInVC: UIViewController {
    
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    @IBOutlet weak var signInlabel: Springable!
    @IBOutlet weak var firstNameTextField: SpringTextField!
    @IBOutlet weak var lastNameTextField: SpringTextField!
    @IBOutlet weak var signInBtn: SpringButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleAnimationIn()
        
    }
    
    func handleAnimationIn(){
        
        signInlabel.animation = "zoomIn"
        signInlabel.delay = 0.6
        signInlabel.duration = 1
        signInlabel.animate()
        
        firstNameTextField.animation = "zoomIn"
        firstNameTextField.delay = 0.9
        firstNameTextField.duration = 1
        firstNameTextField.animate()
        
        lastNameTextField.animation = "zoomIn"
        lastNameTextField.delay = 1.4
        lastNameTextField.duration = 1
        lastNameTextField.animate()
        
        signInBtn.animation = "zoomIn"
        signInBtn.delay = 1.8
        signInBtn.duration = 1
        signInBtn.animate()
        
    }
    
    func handleAnimationOut(user: User?){
        
        signInlabel.animation = "zoomOut"
        signInlabel.delay = 0.5
        signInlabel.duration = 1
        signInlabel.animate()
        
        firstNameTextField.animation = "zoomIn"
        firstNameTextField.delay = 0.9
        firstNameTextField.duration = 1
        firstNameTextField.animateTo()
         
        lastNameTextField.animation = "zoomIn"
        lastNameTextField.delay = 1.4
        lastNameTextField.duration = 1
        lastNameTextField.animateTo()
        
        signInBtn.animation = "zoomIn"
        signInBtn.delay = 1.8
        signInBtn.duration = 1
        signInBtn.animateToNext {
            
            if let loggedInUser = user {
                // go to PostsVC via tab bar after animating
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBar = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
                UserManager.loggedInUser = loggedInUser
                self.firstNameTextField.text = ""
                self.lastNameTextField.text = ""
                tabBar.modalPresentationStyle = .fullScreen
                self.present(tabBar, animated: true)
                
                
            }
        }
        
    }
    
    @IBAction func SignInBtnClicked(_ sender: Any) {
        loaderView.startAnimating()
        UserDataAPI.shared.confirmSignIn(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!) { userResponse, error in
            self.loaderView.stopAnimating()
            if let error = error{
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
                
            }else{
                self.handleAnimationOut(user: userResponse)
            }
        }
    }
    //before handle animating out
            //            if userResponse != nil {
            //                // go to PostsVC
            //                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //                let tabBar = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
            //                UserManager.loggedInUser = userResponse
            //                self.firstNameTextField.text = ""
            //                self.lastNameTextField.text = ""
            //                tabBar.modalPresentationStyle = .fullScreen
            //                self.present(tabBar, animated: true)
            //
            //
            //
            //
            //            }else{
            //                let alert = UIAlertController(title: "Error", message: error!, preferredStyle: .alert)
            //                let okAction = UIAlertAction(title: "OK", style: .default)
            //                alert.addAction(okAction)
            //                self.present(alert, animated: true)
            //            }
            //        }
        
        
        @IBAction func skipBtnClicked(_ sender: Any) {
            // go to PostsVC via TabBarController
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBar = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
            tabBar.modalPresentationStyle = .fullScreen
            self.present(tabBar, animated: true)
        }
        
        @IBAction func goToRegisterVC(_ sender: Any) {
            // go to PostsVC
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let registerVC = mainStoryboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
            registerVC.modalPresentationStyle = .fullScreen
            self.present(registerVC, animated: true)
            //self.dismiss(animated: true)
        }
        
    }
    
    
    
    
    
    
    
    
