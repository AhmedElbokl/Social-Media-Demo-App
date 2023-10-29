//
//  ViewController.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 07/10/2023.
//

import UIKit
import NVActivityIndicatorView

class PostsVC: UIViewController {
    
    var postsArr: [Post] = []
    var user: User?
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = self.user {
            userNameLabel.text = "Hi, \(user.firstName) \(user.lastName)"
        }else{
                userNameLabel.isHidden = true
            }
        NotificationCenter.default.addObserver(self, selector: #selector(profilNotificationRecieved), name: NSNotification.Name("profileBtnClicked"), object: nil)
        postsTableView.dataSource = self
        postsTableView.delegate = self
        
        // animating loader and posts request
        loaderView.startAnimating()
        PostAPI.shared.requestPosts { postsResponse in
            self.postsArr = postsResponse
            self.postsTableView.reloadData()
            self.loaderView.stopAnimating()

        }
        
//        let url = "https://dummyapi.io/data/v1/post"
//
//        let appId = "6531535fe8ca784faf33486e"
//        let headers: HTTPHeaders = [
//            "app-id": appId
//        ]
//
//        loaderView.startAnimating()
//        AF.request(url, headers: headers).responseJSON { response in
//            self.loaderView.stopAnimating()
//            let jsonData = JSON(response.value)
//            let data = jsonData["data"]
//            let decoder = JSONDecoder()
//            do{
//                let decodedData = try decoder.decode([Post].self, from: data.rawData())
//                print(decodedData)
//                self.postsArr = decodedData
//            } catch let error{
//                print(error.localizedDescription)
//            }
//            self.postsTableView.reloadData()
//        }
    }
    
    @objc func profilNotificationRecieved(notification: Notification){
        guard let clickedCell = notification.userInfo?["clickedCell"] as? UITableViewCell else {return}
        guard let indexPath = postsTableView.indexPath(for: clickedCell) else {return}
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        
        profileVC.user = postsArr[indexPath.row].owner

        present(profileVC, animated: true)
    }
    
    @IBAction func lockBtnClicked(_ sender: Any) {
        // go to SignInVC
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let signInVC = mainStoryboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
//        signInVC.modalPresentationStyle = .fullScreen
//        self.present(signInVC, animated: true)
        self.dismiss(animated: true)
    }
}

extension PostsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        //let post = postsArr[indexPath.row]
        
        // convert comment user iamge from url type to uiimage type
//        let stringUrlUserImage = postsArr[indexPath.row].owner.picture
//        if let urlImage = URL(string: stringUrlUserImage ) {
//        URLSession.shared.dataTask(with: urlImage) { (data, response, error) in
//          guard let imageData = data else { return }
//          DispatchQueue.main.async {
//              let image = UIImage(data: imageData)
//              postCell.userImageView.image = image
//              postCell.userImageView.layer.cornerRadius = postCell.userImageView.frame.height / 2
//
//          }
//        }.resume()
//      }
        postCell.userImageView.convertFromStringUrlToUIImage(stringUri: postsArr[indexPath.row].owner.picture ?? "")
        postCell.userImageView.makeCircularImage()
        
        postCell.postUserNameLabel.text = "\(postsArr[indexPath.row].owner.firstName) \(postsArr[indexPath.row].owner.lastName)"
        postCell.postTextLabel.text = postsArr[indexPath.row].text
        
        // Convert UrlImage To UIImage from url type to uiimage type
//        let stringUrlPostImage = postsArr[indexPath.row].image
//        if let urlImage = URL(string: stringUrlPostImage ) {
//        URLSession.shared.dataTask(with: urlImage) { (data, response, error) in
//          guard let imageData = data else { return }
//          DispatchQueue.main.async {
//              let image = UIImage(data: imageData)
//              postCell.postImageView.image = image
//          }
//        }.resume()
//      }
        postCell.postImageView.convertFromStringUrlToUIImage(stringUri: postsArr[indexPath.row].image)
        
  
        postCell.likesNumLabel.text = String(postsArr[indexPath.row].likes)
        
        return postCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = postsArr[indexPath.row]
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let postDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsVC
        postDetailsVC.post = selectedPost
        present(postDetailsVC, animated: true)
//        present(postDetailsVC, animated: true)
        
    }
    
    
}



