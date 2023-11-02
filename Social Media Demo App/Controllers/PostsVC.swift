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
    var tag: String?
    var page: Int = 0
    var total: Int = 0
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagNameLabel: UILabel!
    
    @IBOutlet weak var closeTagPostsBtn: UIButton!
    @IBOutlet weak var addNewPostBtn: UIButton!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let user = UserManager.loggedInUser {
            userNameLabel.text = "Hi, \(user.firstName) \(user.lastName)"
        }else{
            userNameLabel.isHidden = true
            addNewPostBtn.isHidden = true
        }
        //new post added
        NotificationCenter.default.addObserver(self, selector: #selector(newPostNotificationRecieved), name: NSNotification.Name("newPostAdded"), object: nil)
        // profile btn clicked
        NotificationCenter.default.addObserver(self, selector: #selector(profilNotificationRecieved), name: NSNotification.Name("profileBtnClicked"), object: nil)
        
        postsTableView.dataSource = self
        postsTableView.delegate = self
        
        // control tag view and tag name
        if let isThereTag = tag {
            let CurrentTag = isThereTag.trimmingCharacters(in: .whitespaces)
            tagNameLabel.text = CurrentTag
            tagView.layer.cornerRadius = 15
        }else{
            tagView.isHidden = true
            closeTagPostsBtn.isHidden = true
        }
        
        //            // animating loader and All posts request
        //            loaderView.startAnimating()
        //        PostAPI.shared.requestPosts(page: page, tag: tag) { postsResponse in
        //                self.postsArr = postsResponse
        //                self.postsTableView.reloadData()
        //                self.loaderView.stopAnimating()
        //            }
        postsRequest()
        
        
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
    @objc func newPostNotificationRecieved(){
        self.postsArr = []
        self.page = 0
        postsRequest()
    }
    
    @objc func profilNotificationRecieved(notification: Notification){
        guard let clickedCell = notification.userInfo?["clickedCell"] as? UITableViewCell else {return}
        guard let indexPath = postsTableView.indexPath(for: clickedCell) else {return}
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        
        profileVC.user = postsArr[indexPath.row].owner
        
        profileVC.modalPresentationStyle = .fullScreen
        present(profileVC, animated: true)
    }
    
    
    @IBAction func closeTagPostsBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func signOutBtnClicked(_ sender: Any) {
        
         //go to SignInVC
        UserManager.loggedInUser = nil
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let signInVC = mainStoryboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                signInVC.modalPresentationStyle = .fullScreen
                self.present(signInVC, animated: true)
//        self.dismiss(animated: true)
    }
    
    
    @IBAction func addNewPostBtnClicked(_ sender: Any) {
        // go to newPostVC
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newPostVC = mainStoryboard.instantiateViewController(withIdentifier: "NewPostVC") as! NewPostVC
                newPostVC.modalPresentationStyle = .fullScreen
                self.present(newPostVC, animated: true)
    }
    
    func postsRequest(){
        // animating loader and All posts request
        loaderView.startAnimating()
        PostAPI.shared.requestPosts(page: page, tag: tag) { postsResponse, total  in
            self.total = total
            self.postsArr.append(contentsOf: postsResponse)
            self.postsTableView.reloadData()
            self.loaderView.stopAnimating()
        }
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
        postCell.postImageView.layer.cornerRadius = 10
        
        
        postCell.likesNumLabel.text = String(postsArr[indexPath.row].likes)
        postCell.tags = (postsArr[indexPath.row].tags) ?? []
        
        return postCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        520
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = postsArr[indexPath.row]
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let postDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsVC
        postDetailsVC.post = selectedPost
        postDetailsVC.modalPresentationStyle = .fullScreen
        present(postDetailsVC, animated: true)
        //        present(postDetailsVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == postsArr.count - 1 && postsArr.count < total {
            page += 1
            postsRequest()
        }
    }
    
    
}



