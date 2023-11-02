//
//  TagsVC.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 30/10/2023.
//

import UIKit
import NVActivityIndicatorView

class TagsVC: UIViewController {
    
    var tagsArr: [String?] = []
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsCollectionView.dataSource = self
        tagsCollectionView.delegate = self
        
        loaderView.startAnimating()
        PostAPI.shared.requestTags{ tags in
            
            self.tagsArr = tags
            self.tagsCollectionView.reloadData()
            
            self.loaderView.stopAnimating()
            
        }
        
    }
    
}

extension TagsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tagsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        let currentTag = tagsArr[indexPath.row]
        item.tagNameLabel.text = currentTag
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTag = tagsArr[indexPath.row]
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let postVC = mainStoryboard.instantiateViewController(withIdentifier: "PostsVC") as! PostsVC
        postVC.tag = selectedTag
        postVC.modalPresentationStyle = .fullScreen
        present(postVC, animated: true)
    }
    
}
