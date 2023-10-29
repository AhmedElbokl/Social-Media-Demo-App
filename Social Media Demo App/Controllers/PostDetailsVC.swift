//
//  PostsDetailsVC.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 21/10/2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class PostDetailsVC: UIViewController {
    var post: Post!
    var commentArr: [Comment] = []
        
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var backContainerView: UIView!{
        didSet{
            backContainerView.layer.shadowColor = UIColor.gray.cgColor
            backContainerView.layer.shadowOpacity = 0.3
            backContainerView.layer.shadowOffset = CGSize(width: 0, height: 10)
            backContainerView.layer.shadowRadius = 10
            backContainerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likesNumLabel: UILabel!
    
    @IBOutlet weak var commentsTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        
        //convert user image from url type to uiimage type
//        let stringUrlUserImage = post.owner.picture
//        if let urlImage = URL(string: stringUrlUserImage) {
//            URLSession.shared.dataTask(with: urlImage) { (data, response, error) in
//                guard let imageData = data else { return }
//                DispatchQueue.main.async {
//                    let image = UIImage(data: imageData)
//                    self.userImageView.image = image
//                    self.userImageView.layer.cornerRadius = self.userImageView.frame.height / 2
//                }
//            }.resume()
//        }
        self.userImageView.convertFromStringUrlToUIImage(stringUri: post.owner.picture ?? "")
        self.userImageView.makeCircularImage()
        userNameLable.text = post.owner.firstName + " " + post.owner.lastName
        postTextLabel.text = post.text
        //convert post image from url type to uiimage type
//        let stringUrlPostImage = post.image
//        if let urlImage = URL(string: stringUrlPostImage ) {
//            URLSession.shared.dataTask(with: urlImage) { (data, response, error) in
//                guard let imageData = data else { return }
//                DispatchQueue.main.async {
//                    let image = UIImage(data: imageData)
//                    self.postImageView.image = image
//                }
//            }.resume()
//        }
        self.postImageView.convertFromStringUrlToUIImage(stringUri: post.image)
        self.postImageView.layer.cornerRadius = 10
        
        likesNumLabel.text = String(post.likes)
        
        // aminating loader and post comments request
        loaderView.startAnimating()
        PostAPI.shared.requestPostComments(postId: post.id) { commentResponse in
            self.commentArr = commentResponse
            self.commentsTableView.reloadData()
            self.loaderView.stopAnimating()
        }
        //request comments form server
//        let postId = post.id
//        let url = "https://dummyapi.io/data/v1/post/\(postId)/comment"
//        let appId = "6531535fe8ca784faf33486e"
//        let headers: HTTPHeaders = [
//            "app-id": appId
//        ]
//        loaderView.startAnimating()
//        AF.request(url, headers: headers).responseJSON { response in
//            self.loaderView.stopAnimating()
//            let jsonData = JSON(response.value)
//            let data = jsonData["data"]
//                let decoder = JSONDecoder()
//                do{
//                    let decodedData = try decoder.decode([Comment].self, from: data.rawData())
//                    print(decodedData)
//                    self.commentArr = decodedData
//                } catch let error{
//                    print(error.localizedDescription)
//                }
//            self.commentsTableView.reloadData()
//        }
   }
}

extension PostDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        
        commentCell.commentTextLabel.text = commentArr[indexPath.row].message
        
        commentCell.commentUserNameLabel.text = commentArr[indexPath.row].owner.firstName + " " + commentArr[indexPath.row].owner.lastName
        
        // convert comment user iamge from url type to uiimage type
//        let stringUrlCommentUserImage = commentArr[indexPath.row].owner.picture
//        if let urlImage = URL(string: stringUrlCommentUserImage ) {
//            URLSession.shared.dataTask(with: urlImage) { (data, response, error) in
//                guard let imageData = data else { return }
//                DispatchQueue.main.async {
//                    let image = UIImage(data: imageData)
//                    commentCell.commentUserImage.image = image
//                }
//            }.resume()
//        }
        commentCell.commentUserImage.convertFromStringUrlToUIImage(stringUri: commentArr[indexPath.row].owner.picture ?? "")
        commentCell.commentUserImage.makeCircularImage()

        return commentCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
100
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
