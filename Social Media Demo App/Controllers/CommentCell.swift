//
//  CommentCell.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 22/10/2023.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var commentUserImage: UIImageView!
    @IBOutlet weak var commentUserNameLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
