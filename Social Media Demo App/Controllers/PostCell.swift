//
//  PostCell.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 20/10/2023.
//

import UIKit

class PostCell: UITableViewCell {
    
    var tags: [String] = []
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!{
        didSet{
            tagsCollectionView.dataSource = self
            tagsCollectionView.delegate = self
        }
    }
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
    @IBOutlet weak var postUserNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesNumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func profileBtnClicked(_ sender: Any) {
        let clickedCell = self
        NotificationCenter.default.post(name: NSNotification.Name("profileBtnClicked"), object: nil, userInfo: ["clickedCell": clickedCell])
    }
    
}

// extension for tags collection view
extension PostCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "PostTagsCell", for: indexPath) as! PostTagsCell
        item.tagNameLabel.text = tags[indexPath.row]
        
        
        
        return item
    }
    
}
